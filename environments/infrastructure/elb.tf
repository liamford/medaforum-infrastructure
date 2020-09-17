### ALB

resource "aws_alb" "main" {
    name = "medaforum-ecs-alb"
    subnets = "${aws_subnet.public.*.id}"
    security_groups = [
        aws_security_group.lb.id]
    tags = {
        Name = "main-alb"
        environment = var.profile
    }
}

resource "aws_alb_target_group" "medaforum_app" {
    name = "medaforum-ecs-target-group"
    port = var.app_port
    protocol = "HTTP"
    vpc_id = aws_vpc.main.id
    target_type = "ip"
    health_check {
        healthy_threshold   = 3
        unhealthy_threshold = 5
        timeout             = 30
        path                = "/actuator/health"
        interval            = 60
    }
    stickiness {
        type = "lb_cookie"
        enabled = true
    }
    tags = {
        Name = "medaforum_app_target_group"
        environment = var.profile
    }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
    load_balancer_arn = aws_alb.main.id
    port = "80"
    protocol = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.medaforum_app.id
        type = "forward"
    }
}

resource "aws_alb" "admin" {
    name = "admin-ecs-alb"
    subnets = "${aws_subnet.public.*.id}"
    security_groups = [
        aws_security_group.lb.id]
    tags = {
        Name = "admin-alb"
        environment = var.profile
    }
}

resource "aws_alb_target_group" "admin_app" {
    name = "admin-ecs-target-group"
    port = var.app_port
    protocol = "HTTP"
    vpc_id = aws_vpc.main.id
    target_type = "ip"
    health_check {
        healthy_threshold   = 3
        unhealthy_threshold = 5
        timeout             = 30
        path                = "/actuator/health"
        interval            = 60
    }
    stickiness {
        type = "lb_cookie"
        enabled = true
    }
    tags = {
        Name = "medaforum_admin_target_group"
        environment = var.profile
    }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "back_end" {
    load_balancer_arn = aws_alb.admin.id
    port = "80"
    protocol = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.admin_app.id
        type = "forward"
    }
}
