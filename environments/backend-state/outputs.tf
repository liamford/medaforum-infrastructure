output "ecr-general_url" {
    value = module.general_ecr.repository_url
}

output "ecr-admin_url" {
    value = module.admin_ecr.repository_url
}

output "ecr-sms_url" {
    value = module.sms_ecr.repository_url
}

output "ecr-email_url" {
    value = module.email_ecr.repository_url
}
