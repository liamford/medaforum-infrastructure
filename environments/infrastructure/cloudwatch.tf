resource "aws_cloudwatch_log_group" "medaforum_log_group" {
    name = "/ecs/medaforum_app"
    retention_in_days = 30

    tags = {
        Name = "medaforum-log-group"
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

resource "aws_cloudwatch_log_stream" "sb_log_stream" {
    name = "medaforum-app-log-stream"
    log_group_name = "${aws_cloudwatch_log_group.medaforum_log_group.name}"
}

resource "aws_cloudwatch_log_stream" "sms_log_stream" {
    name = "medaforum-sms-log-stream"
    log_group_name = "${aws_cloudwatch_log_group.sms_log_group.name}"
}
