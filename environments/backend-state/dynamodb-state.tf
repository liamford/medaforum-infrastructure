resource "aws_dynamodb_table" "dynamodb_state" {
    name = "${var.dynamodb_table_name}"
    read_capacity = 1
    write_capacity = 1
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        Name = "dynamodb_state"
        environment = var.profile
    }
}
