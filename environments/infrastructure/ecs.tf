### ECS

resource "aws_ecs_cluster" "main" {
    name = "medaforum-ecs-cluster"
}


data "aws_iam_role" "ecs_task_execution_role" {
    name = "ecsExecTaskRole"
}
data "aws_ecr_repository" "ecr" {
    name = "medaforum"
}

data "aws_ecr_repository" "ecr_sms" {
    name = "sms"
}

data "aws_ecr_repository" "ecr_email" {
    name = "email"
}
resource "aws_ecs_task_definition" "medaforum_app" {
    family = "medaforum_app"
    network_mode = "awsvpc"
    requires_compatibilities = [
        "FARGATE"]
    cpu = var.fargate_cpu
    memory = var.fargate_memory
    execution_role_arn = "${data.aws_iam_role.ecs_task_execution_role.arn}"
    tags = {
        Name = "medaforum_app"
        environment = var.profile
    }
    container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.fargate_cpu},
    "image": "${data.aws_ecr_repository.ecr.repository_url}",
    "memory": ${var.fargate_memory},
    "name": "medaforum_app",
    "networkMode": "awsvpc",
    "environment": [
            {"name": "region", "value": "${var.region}"},
            {"name": "endpoint", "value": "dynamodb.${var.region}.amazonaws.com"},
            {"name": "sns", "value": "${var.sns}"},
            {"name": "okta_issuer", "value": "${var.okta_issuer}"}
        ],
    "secrets": [
            {"name": "aws_key", "valueFrom": "${aws_ssm_parameter.access.arn}"},
            {"name": "aws_secret", "valueFrom": "${aws_ssm_parameter.secret.arn}"},
            {"name": "okta_client_id", "valueFrom": "${aws_ssm_parameter.okta_id.arn}"},
            {"name": "okta_client_secret", "valueFrom": "${aws_ssm_parameter.okta_secret.arn}"}
        ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/medaforum_app",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": ${var.app_port},
        "hostPort": ${var.app_port}
      }
    ]
  }
]
DEFINITION
}
resource "aws_ecs_task_definition" "medaforum_sms" {
    family = "medaforum_sms"
    network_mode = "awsvpc"
    requires_compatibilities = [
        "FARGATE"]
    cpu = var.fargate_cpu
    memory = var.fargate_memory
    execution_role_arn = "${data.aws_iam_role.ecs_task_execution_role.arn}"
    tags = {
        Name = "medaforum_sms"
        environment = var.profile
    }
    container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.fargate_cpu},
    "image": "${data.aws_ecr_repository.ecr_sms.repository_url}",
    "memory": ${var.fargate_memory},
    "name": "medaforum_sms",
    "networkMode": "awsvpc",
    "environment": [
            {"name": "region", "value": "${var.region}"}
        ],
    "secrets": [
            {"name": "aws_key", "valueFrom": "${aws_ssm_parameter.access.arn}"},
            {"name": "aws_secret", "valueFrom": "${aws_ssm_parameter.secret.arn}"},
            {"name": "sid", "valueFrom": "${aws_ssm_parameter.sid.arn}"},
            {"name": "token", "valueFrom": "${aws_ssm_parameter.token.arn}"},
            {"name": "sender_phone", "valueFrom": "${aws_ssm_parameter.sender_phone.arn}"}
        ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/medaforum_sms",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": ${var.sms_app_port},
        "hostPort": ${var.sms_app_port}
      }
    ]
  }
]
DEFINITION
}
resource "aws_ecs_task_definition" "medaforum_email" {
    family = "medaforum_email"
    network_mode = "awsvpc"
    requires_compatibilities = [
        "FARGATE"]
    cpu = var.fargate_cpu
    memory = var.fargate_memory
    execution_role_arn = "${data.aws_iam_role.ecs_task_execution_role.arn}"
    tags = {
        Name = "medaforum_email"
        environment = var.profile
    }
    container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.fargate_cpu},
    "image": "${data.aws_ecr_repository.ecr_email.repository_url}",
    "memory": ${var.fargate_memory},
    "name": "medaforum_email",
    "networkMode": "awsvpc",
    "environment": [
            {"name": "region", "value": "${var.region}"},
            {"question_template_id": "region", "value": "${var.question_template_id}"}
        ],
    "secrets": [
            {"name": "aws_key", "valueFrom": "${aws_ssm_parameter.access.arn}"},
            {"name": "aws_secret", "valueFrom": "${aws_ssm_parameter.secret.arn}"},
            {"name": "email_api_token", "valueFrom": "${aws_ssm_parameter.email_api_token.arn}"}
        ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/medaforum_sms",
          "awslogs-region": "${var.region}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": ${var.sms_app_port},
        "hostPort": ${var.sms_app_port}
      }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "main" {
    name = "medaforum-ecs-service"
    cluster = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.medaforum_app.arn
    desired_count = var.app_count
    launch_type = "FARGATE"

    network_configuration {
        security_groups = [
            aws_security_group.ecs_tasks.id]
        subnets = "${aws_subnet.private.*.id}"
    }

    load_balancer {
        target_group_arn = aws_alb_target_group.medaforum_app.id
        container_name = "medaforum_app"
        container_port = var.app_port
    }


    depends_on = [
        aws_alb_listener.front_end
    ]
}

resource "aws_ecs_service" "sms_service" {
    name = "sms-ecs-service"
    cluster = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.medaforum_sms.arn
    desired_count = var.app_count
    launch_type = "FARGATE"

    network_configuration {
        security_groups = [
            aws_security_group.ecs_sms_tasks.id]
        subnets = "${aws_subnet.private.*.id}"
    }

    depends_on = [
        aws_alb_listener.front_end
    ]
}

resource "aws_ecs_service" "email_service" {
    name = "email-ecs-service"
    cluster = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.medaforum_email.arn
    desired_count = var.app_count
    launch_type = "FARGATE"

    network_configuration {
        security_groups = [
            aws_security_group.ecs_email_tasks.id]
        subnets = "${aws_subnet.private.*.id}"
    }

    depends_on = [
        aws_alb_listener.front_end
    ]
}
