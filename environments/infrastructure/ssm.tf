resource "aws_ssm_parameter" "access" {
    name        = "/dynamodb/access"
    description = "The parameter description"
    type        = "SecureString"
    value       = "${var.dynamodb_access_key}"

    tags = {
        Name = "ssm-dynamodb-access"
        environment = var.profile
    }
}

resource "aws_ssm_parameter" "secret" {
    name        = "/dynamodb/secret"
    description = "The parameter description"
    type        = "SecureString"
    value       = "${var.dynamodb_secret}"

    tags = {
        Name = "ssm-dynamodb-secret"
        environment = var.profile
    }
}
