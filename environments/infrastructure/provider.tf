provider "aws" {
    region = var.region
    version = "~> 3.0"
    profile = var.profile
}

terraform {
    backend "s3" {
        bucket = "medaforum-s3-bucket-state"
        key = "terraform/tfstate"
        encrypt = false
        region = "ap-southeast-2"
        dynamodb_table = "medaforum-dynamodb-table-state"
        profile = "medaforum"
    }
}
