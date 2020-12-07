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

data "aws_ecr_repository" "ecr_admin" {
    name = "admin"
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
    cpu = var.site_cpu
    memory = var.site_memory
    execution_role_arn = "${data.aws_iam_role.ecs_task_execution_role.arn}"
    tags = {
        Name = "medaforum_app"
        environment = var.profile
    }
    container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.site_cpu},
    "image": "${data.aws_ecr_repository.ecr.repository_url}",
    "memory": ${var.site_memory},
    "name": "medaforum_app",
    "networkMode": "awsvpc",
    "environment": [
            {"name": "region", "value": "${var.region}"},
            {"name": "endpoint", "value": "dynamodb.${var.region}.amazonaws.com"},
            {"name": "sns", "value": "${var.sns}"},
            {"name": "okta_issuer", "value": "${var.okta_issuer}"},
            {"name": "algolia_index", "value": "${var.algolia_index}"}
        ],
    "secrets": [
            {"name": "aws_key", "valueFrom": "${aws_ssm_parameter.access.arn}"},
            {"name": "aws_secret", "valueFrom": "${aws_ssm_parameter.secret.arn}"},
            {"name": "sid", "valueFrom": "${aws_ssm_parameter.sid.arn}"},
            {"name": "token", "valueFrom": "${aws_ssm_parameter.token.arn}"},
            {"name": "okta_client_id", "valueFrom": "${aws_ssm_parameter.okta_id.arn}"},
            {"name": "okta_client_secret", "valueFrom": "${aws_ssm_parameter.okta_secret.arn}"},
            {"name": "algolia_application", "valueFrom": "${aws_ssm_parameter.algolia_application_id.arn}"},
            {"name": "algolia_key", "valueFrom": "${aws_ssm_parameter.algolia_api_key.arn}"}
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
resource "aws_ecs_task_definition" "medaforum_admin" {
    family = "medaforum_admin"
    network_mode = "awsvpc"
    requires_compatibilities = [
        "FARGATE"]
    cpu = var.admin_cpu
    memory = var.admin_memory
    execution_role_arn = "${data.aws_iam_role.ecs_task_execution_role.arn}"
    tags = {
        Name = "medaforum_admin"
        environment = var.profile
    }
    container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.admin_cpu},
    "image": "${data.aws_ecr_repository.ecr_admin.repository_url}",
    "memory": ${var.admin_memory},
    "name": "medaforum_admin",
    "networkMode": "awsvpc",
    "environment": [
            {"name": "region", "value": "${var.region}"},
            {"name": "endpoint", "value": "dynamodb.${var.region}.amazonaws.com"},
            {"name": "sns", "value": "${var.sns}"},
            {"name": "okta_issuer", "value": "${var.okta_issuer}"},
            {"name": "algolia_index", "value": "${var.algolia_index}"}
        ],
    "secrets": [
            {"name": "aws_key", "valueFrom": "${aws_ssm_parameter.access.arn}"},
            {"name": "aws_secret", "valueFrom": "${aws_ssm_parameter.secret.arn}"},
            {"name": "okta_client_id", "valueFrom": "${aws_ssm_parameter.okta_admin_id.arn}"},
            {"name": "okta_client_secret", "valueFrom": "${aws_ssm_parameter.okta_admin_secret.arn}"},
            {"name": "algolia_application", "valueFrom": "${aws_ssm_parameter.algolia_application_id.arn}"},
            {"name": "algolia_key", "valueFrom": "${aws_ssm_parameter.algolia_api_key.arn}"}
        ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/medaforum_admin",
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
    cpu = var.notification_cpu
    memory = var.notification_memory
    execution_role_arn = "${data.aws_iam_role.ecs_task_execution_role.arn}"
    tags = {
        Name = "medaforum_sms"
        environment = var.profile
    }
    container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.notification_cpu},
    "image": "${data.aws_ecr_repository.ecr_sms.repository_url}",
    "memory": ${var.notification_memory},
    "name": "medaforum_sms",
    "networkMode": "awsvpc",
    "environment": [
            {"name": "region", "value": "${var.region}"},
            {"name": "medaforum_url", "value": "https://www.medaforum.com"}
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
    cpu = var.notification_cpu
    memory = var.notification_memory
    execution_role_arn = "${data.aws_iam_role.ecs_task_execution_role.arn}"
    tags = {
        Name = "medaforum_email"
        environment = var.profile
    }
    container_definitions = <<DEFINITION
[
  {
    "cpu": ${var.notification_cpu},
    "image": "${data.aws_ecr_repository.ecr_email.repository_url}",
    "memory": ${var.notification_memory},
    "name": "medaforum_email",
    "networkMode": "awsvpc",
    "environment": [
            {"name": "medaforum_url", "value": "https://www.medaforum.com"},
            {"name": "admin_url", "value": "https://www.business.medaforum.com"},
            {"name": "region", "value": "${var.region}"},
            {"name": "user_template_question_id", "value": "${var.user_template_question_id}"},
            {"name": "user_template_answer_id", "value": "${var.user_template_answer_id}"},
            {"name": "admin_template_question_id", "value": "${var.admin_template_question_id}"},
            {"name": "admin_template_moreinfo_id", "value": "${var.admin_template_moreinfo_id}"},
            {"name": "user_template_moreinfo_id", "value": "${var.user_template_moreinfo_id}"}
        ],
    "secrets": [
            {"name": "aws_key", "valueFrom": "${aws_ssm_parameter.access.arn}"},
            {"name": "aws_secret", "valueFrom": "${aws_ssm_parameter.secret.arn}"},
            {"name": "email_api_token", "valueFrom": "${aws_ssm_parameter.email_api_token.arn}"}
        ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/medaforum_email",
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
    desired_count = var.main_app_count
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

resource "aws_ecs_service" "admin" {
    name = "admin-ecs-service"
    cluster = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.medaforum_admin.arn
    desired_count = var.main_app_count
    launch_type = "FARGATE"

    network_configuration {
        security_groups = [
            aws_security_group.ecs_tasks.id]
        subnets = "${aws_subnet.private.*.id}"
    }

    load_balancer {
        target_group_arn = aws_alb_target_group.admin_app.id
        container_name = "medaforum_admin"
        container_port = var.app_port
    }


    depends_on = [
        aws_alb_listener.back_end
    ]
}

resource "aws_ecs_service" "sms_service" {
    name = "sms-ecs-service"
    cluster = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.medaforum_sms.arn
    desired_count = var.notification_app_count
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
    desired_count = var.notification_app_count
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

resource "aws_appautoscaling_target" "site_scale_target" {
    service_namespace  = "ecs"
    resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.main.name}"
    scalable_dimension = "ecs:service:DesiredCount"
    max_capacity       = var.ecs_autoscale_max_instances
    min_capacity       = var.ecs_autoscale_min_instances
}

resource "aws_appautoscaling_target" "site_scale_mem_target" {
    service_namespace  = "ecs"
    resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.main.name}"
    scalable_dimension = "ecs:service:DesiredCount"
    max_capacity       = var.ecs_autoscale_max_instances
    min_capacity       = var.ecs_autoscale_min_instances
}
