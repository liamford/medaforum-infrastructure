variable "region" {
    type = string
}

variable "profile" {
    type = string
}

variable "az_count" {
    description = "Number of AZs to cover in a given AWS region"
    default     = "2"
}


variable "app_port" {
    description = "Port exposed by the docker image to redirect traffic to"
    default     = 80
}

variable "sms_app_port" {
    description = "Port exposed by the docker image to redirect traffic to"
    default     = 8080
}

variable "email_app_port" {
    description = "Port exposed by the docker image to redirect traffic to"
    default     = 8080
}

variable "app_count" {
    description = "Number of docker containers to run"
    default     = 2
}

variable "fargate_cpu" {
    description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
    default     = "1024"
}

variable "fargate_memory" {
    description = "Fargate instance memory to provision (in MiB)"
    default     = "2048"
}

variable "service_access_key" {
    description = "access key"
}

variable "service_secret" {
    description = "Secret"
}

variable "sid" {
    description = "sid"
}
variable "token" {
    description = "token"
}

variable "sender_phone" {
    description = "sender_phone"
}

variable "okta_client_id" {
    description = "okta_client_id"
}

variable "okta_admin_client_id" {
    description = "okta_admin_client_id"
}

variable "okta_client_secret" {
    description = "okta_client_secret"
}

variable "okta_admin_client_secret" {
    description = "okta_admin-client_secret"
}

variable "okta_issuer" {
    description = "okta_client_secret"
}

variable "email_api_token" {
    description = "email_api_token"
}

variable "algolia_application_id" {
    description = "algolia_application_id"
}

variable "algolia_api_key" {
    description = "algolia_api_key"
}

variable "algolia_index" {
    type = string
    default = "prod"
}

variable "sns" {
    type = string
    default = "questions"
}
variable "user_template_question_id" {
    type = string
    default = "d-91db01aeea294061848760d862688e33"
}
variable "user_template_answer_id" {
    type = string
    default = "d-07bb3acabacb4246aad9b91ec7740878"
}
variable "admin_template_question_id" {
    type = string
    default = "d-e7c844b9904c47378566af53764a8a6f"
}
variable "admin_template_moreinfo_id" {
    type = string
    default = "d-96a6854a0cdf46d9873485f1abbcf462"
}

variable "user_template_moreinfo_id" {
    type = string
    default = "d-cc2ec3b027b645cea98cf4490889ab4b"
}


