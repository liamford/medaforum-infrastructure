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

resource "aws_ssm_parameter" "okta_admin_id" {
    name        = "/okta/admin_client_id"
    description = "The parameter description"
    type        = "SecureString"
    value       = "${var.okta_admin_client_id}"

    tags = {
        Name = "ssm-okta-admin-client-id"
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

resource "aws_ssm_parameter" "okta_admin_secret" {
    name = "/okta/admin_client_secret"
    description = "The parameter description"
    type = "SecureString"
    value = "${var.okta_admin_client_secret}"

    tags = {
        Name = "ssm-okta-admin-client-secret"
        environment = var.profile
    }
}

resource "aws_ssm_parameter" "email_api_token" {
    name        = "/twilio/email_api_token"
    description = "The parameter description"
    type        = "SecureString"
    value       = "${var.email_api_token}"

    tags = {
        Name = "ssm-email-api-secret"
        environment = var.profile
    }
}
