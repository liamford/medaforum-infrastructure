provider "aws" {
    region = var.region
    version = "~> 3.0"
    profile = var.profile
}

terraform {
    backend "s3" {
        bucket = "medaforum-s3-bucket-state-dev-one"
        key = "terraform/tfstate"
        encrypt = false
        region = "us-east-1"
        dynamodb_table = "medaforum-dynamodb-table-state-dev"
        profile = "dev"
    }
}
