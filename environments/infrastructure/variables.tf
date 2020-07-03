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

variable "sns" {
    type = string
    default = "questions"
}


