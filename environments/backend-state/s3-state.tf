resource "aws_s3_bucket" "s3_bucket_state" {
    bucket = "${var.bucket_name}"
    acl    = "private"

    versioning {
        enabled = false
    }
    tags = {
        Name = "s3_bucket_state"
        environment = var.profile
    }
}
