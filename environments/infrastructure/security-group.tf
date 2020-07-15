### Security

# ALB Security group
# This is the group you need to edit if you want to restrict access to your application
resource "aws_security_group" "lb" {
    name = "medaforum-ecs-alb"
    description = "controls access to the ALB"
    vpc_id = aws_vpc.main.id

    ingress {
        description = "HTTP Port"
        protocol = "tcp"
        from_port = 80
        to_port = 80
        cidr_blocks = [
            "0.0.0.0/0"]
    }

    ingress {
        description = "TLS from VPC"
        protocol = "tcp"
        from_port = 443
        to_port = 443
        cidr_blocks = [
            "0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"]
    }
    tags = {
        Name = "lb_security_group"
        environment = var.profile
    }
}

# Traffic to the ECS Cluster should only come from the ALB
resource "aws_security_group" "ecs_tasks" {
    name = "medaforum-ecs-tasks"
    description = "allow inbound access from the ALB only"
    vpc_id = aws_vpc.main.id

    ingress {
        protocol = "tcp"
        from_port = var.app_port
        to_port = var.app_port
        security_groups = [
            aws_security_group.lb.id]
    }

    ingress {
        protocol = "tcp"
        from_port = 80
        to_port = 80
        security_groups = [
            aws_security_group.lb.id]
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = [
            "0.0.0.0/0"]
    }

    tags = {
        Name = "ecs_security_group"
        environment = var.profile
    }
}

resource "aws_security_group" "ecs_sms_tasks" {
    name = "medaforum-sms-tasks"
    description = "allow inbound access from the ALB only"
    vpc_id = aws_vpc.main.id

    ingress {
        protocol = "tcp"
        from_port = var.sms_app_port
        to_port = var.sms_app_port
        security_groups = [
            aws_security_group.lb.id]
    }

    ingress {
        protocol = "tcp"
        from_port = 8080
        to_port = 8080
        security_groups = [
            aws_security_group.lb.id]
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = [
            "0.0.0.0/0"]
    }

    tags = {
        Name = "ecs_security_group"
        environment = var.profile
    }
}

resource "aws_security_group" "ecs_email_tasks" {
    name = "medaforum-email-tasks"
    description = "allow inbound access from the ALB only"
    vpc_id = aws_vpc.main.id

    ingress {
        protocol = "tcp"
        from_port = var.email_app_port
        to_port = var.email_app_port
        security_groups = [
            aws_security_group.lb.id]
    }

    ingress {
        protocol = "tcp"
        from_port = 8080
        to_port = 8080
        security_groups = [
            aws_security_group.lb.id]
    }

    egress {
        protocol = "-1"
        from_port = 0
        to_port = 0
        cidr_blocks = [
            "0.0.0.0/0"]
    }

    tags = {
        Name = "ecs_security_group"
        environment = var.profile
    }
}
