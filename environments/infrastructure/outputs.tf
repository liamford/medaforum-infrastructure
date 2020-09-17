output "alb_hostname" {
    value = aws_alb.main.dns_name
}

output "alb_admin" {
    value = aws_alb.admin.dns_name
}
