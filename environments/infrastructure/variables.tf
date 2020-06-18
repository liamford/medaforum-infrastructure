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

variable "dynamodb_access_key" {
    description = "access key"
    default     = "AKIA4JN5DTNMHYI7GSEM"
}

variable "dynamodb_secret" {
    description = "Secret"
    default     = "ic7t14VwLshmL6dr013XNNZretHEe0XTOdt+6Ps1"
}


