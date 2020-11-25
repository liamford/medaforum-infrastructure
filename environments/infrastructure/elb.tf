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
        type = "redirect"

        redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}

resource "aws_lb_listener" "front_end_https" {
    load_balancer_arn = aws_alb.main.id
    port              = "443"
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = "arn:aws:acm:ap-southeast-2:429479441548:certificate/eab84f72-19f0-40e1-ac78-68d7712acf1a"

    default_action {
        type             = "forward"
        target_group_arn = aws_alb_target_group.medaforum_app.id
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
        type = "redirect"

        redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}

resource "aws_lb_listener" "back_end_https" {
    load_balancer_arn = aws_alb.admin.id
    port              = "443"
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = "arn:aws:acm:ap-southeast-2:429479441548:certificate/5177aa43-6c9c-4e5a-b4ad-470a2a7af0d6"

    default_action {
        type             = "forward"
        target_group_arn = aws_alb_target_group.admin_app.id
    }
}
