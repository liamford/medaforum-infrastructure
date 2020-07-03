
output "ecr-general_url" {
    value = module.general_ecr.repository_url
}

output "ecr-sms_url" {
    value = module.sms_ecr.repository_url
}
