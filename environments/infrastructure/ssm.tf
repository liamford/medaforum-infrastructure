resource "aws_ssm_parameter" "access" {
    name        = "/dynamodb/access"
    description = "The parameter description"
    type        = "SecureString"
    value       = "${var.service_access_key}"

    tags = {
        Name = "ssm-dynamodb-access"
        environment = var.profile
    }
}

resource "aws_ssm_parameter" "secret" {
    name        = "/dynamodb/secret"
    description = "The parameter description"
    type        = "SecureString"
    value       = "${var.service_secret}"

    tags = {
        Name = "ssm-dynamodb-secret"
        environment = var.profile
    }
}

resource "aws_ssm_parameter" "sid" {
    name        = "/twilio/sid"
    description = "The parameter description"
    type        = "SecureString"
    value       = "${var.sid}"

    tags = {
        Name = "ssm-twilio-secret"
        environment = var.profile
    }
}

resource "aws_ssm_parameter" "token" {
    name        = "/twilio/token"
    description = "The parameter description"
    type        = "SecureString"
    value       = "${var.token}"

    tags = {
        Name = "ssm-twilio-secret"
        environment = var.profile
    }
}

resource "aws_ssm_parameter" "sender_phone" {
    name        = "/twilio/sender_phone"
    description = "The parameter description"
    type        = "SecureString"
    value       = "${var.sender_phone}"

    tags = {
        Name = "ssm-twilio-secret"
        environment = var.profile
    }
}

resource "aws_ssm_parameter" "okta_id" {
    name        = "/okta/client_id"
    description = "The parameter description"
    type        = "SecureString"
    value       = "${var.okta_client_id}"

    tags = {
        Name = "ssm-okta-client-id"
        environment = var.profile
    }
}

resource "aws_ssm_parameter" "okta_secret" {
    name        = "/okta/client_secret"
    description = "The parameter description"
    type        = "SecureString"
    value       = "${var.okta_client_secret}"

    tags = {
        Name = "ssm-okta-client-secret"
        environment = var.profile
    }
}
