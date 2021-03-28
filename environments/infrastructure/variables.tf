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

variable "main_app_count" {
    description = "Number of docker containers to run"
    default     = 1
}

variable "admin_app_count" {
    description = "Number of docker containers to run"
    default     = 1
}

variable "notification_app_count" {
    description = "Number of docker containers to run"
    default     = 1
}

variable "site_cpu" {
    description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
    default     = "1024"
}

variable "admin_cpu" {
    description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
    default     = "512"
}

variable "notification_cpu" {
    description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
    default     = "512"
}

variable "site_memory" {
    description = "Fargate instance memory to provision (in MiB)"
    default     = "2048"
}

variable "admin_memory" {
    description = "Fargate instance memory to provision (in MiB)"
    default     = "1024"
}


variable "notification_memory" {
    description = "Fargate instance memory to provision (in MiB)"
    default     = "1024"
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

variable "ecs_as_cpu_low_threshold_per" {
    default = "20"
}

# If the average CPU utilization over a minute rises to this threshold,
# the number of containers will be increased (but not above ecs_autoscale_max_instances).
variable "ecs_as_cpu_high_threshold_per" {
    default = "80"
}

variable "ecs_as_memory_high_threshold_per" {
    default = "80"
}

variable "ecs_as_memory_low_threshold_per" {
    default = "5"
}

variable "ecs_autoscale_min_instances" {
    default = "1"
}

# The maximum number of containers that should be running.
# used by both autoscale-perf.tf and autoscale.time.tf
variable "ecs_autoscale_max_instances" {
    default = "8"
}

