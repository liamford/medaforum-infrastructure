resource "aws_cloudwatch_log_group" "medaforum_log_group" {
    name = "/ecs/medaforum_app"
    retention_in_days = 30

    tags = {
        Name = "medaforum-log-group"
        environment = var.profile
    }
}

resource "aws_cloudwatch_log_group" "admin_log_group" {
    name = "/ecs/medaforum_admin"
    retention_in_days = 30

    tags = {
        Name = "medaforum-admin-log-group"
        environment = var.profile
    }
}

resource "aws_cloudwatch_log_group" "sms_log_group" {
    name = "/ecs/medaforum_sms"
    retention_in_days = 30

    tags = {
        Name = "medaforum-sms-log-group"
        environment = var.profile
    }
}

resource "aws_cloudwatch_log_group" "email_log_group" {
    name = "/ecs/medaforum_email"
    retention_in_days = 30

    tags = {
        Name = "medaforum-email-log-group"
        environment = var.profile
    }
}

resource "aws_cloudwatch_log_stream" "site_log_stream" {
    name = "medaforum-site-log-stream"
    log_group_name = "${aws_cloudwatch_log_group.medaforum_log_group.name}"
}

resource "aws_cloudwatch_log_stream" "admin_log_stream" {
    name = "medaforum-admin-log-stream"
    log_group_name = "${aws_cloudwatch_log_group.admin_log_group.name}"
}

resource "aws_cloudwatch_log_stream" "email_log_stream" {
    name = "medaforum-email-log-stream"
    log_group_name = "${aws_cloudwatch_log_group.email_log_group.name}"
}

resource "aws_cloudwatch_log_stream" "sms_log_stream" {
    name = "medaforum-sms-log-stream"
    log_group_name = "${aws_cloudwatch_log_group.sms_log_group.name}"
}
