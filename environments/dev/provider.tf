provider "aws" {
    region     = var.region
    version    = "~> 2.63"
    profile = var.profile
}
