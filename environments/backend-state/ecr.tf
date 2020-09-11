module "general_ecr" {
    source = "QuiNovas/ecr/aws"
    version = "3.0.0"
    name = "medaforum"
}

module "admin_ecr" {
    source = "QuiNovas/ecr/aws"
    version = "3.0.0"
    name = "admin"
}

module "sms_ecr" {
    source = "QuiNovas/ecr/aws"
    version = "3.0.0"
    name = "sms"
}

module "email_ecr" {
    source = "QuiNovas/ecr/aws"
    version = "3.0.0"
    name = "email"
}
