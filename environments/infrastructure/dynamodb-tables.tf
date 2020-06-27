resource "aws_dynamodb_table" "basic-dynamodb-table" {
    name           = "Questions"
    billing_mode   = "PROVISIONED"
    read_capacity  = 2
    write_capacity = 2
    hash_key       = "QuestionId"
    range_key      = "UserId"

    attribute {
        name = "QuestionId"
        type = "S"
    }

    attribute {
        name = "QuestionTitle"
        type = "S"
    }

    attribute {
        name = "Timestamp"
        type = "S"
    }

    attribute {
        name = "UserId"
        type = "S"
    }

    attribute {
        name = "Status"
        type = "N"
    }

    attribute {
        name = "QuestionGroup"
        type = "N"
    }

    local_secondary_index {
        name = "QuestionTitleIndex"
        projection_type = "ALL"
        range_key = "QuestionTitle"
    }


    global_secondary_index {
        name               = "QuestionStatusIndex"
        hash_key           = "Status"
        range_key          = "Timestamp"
        write_capacity     = 2
        read_capacity      = 2
        projection_type    = "INCLUDE"
        non_key_attributes = ["QuestionId","QuestionTitle","UserId"]
    }

    global_secondary_index {
        name               = "QuestionGroupIndex"
        hash_key           = "QuestionGroup"
        range_key          = "Timestamp"
        write_capacity     = 2
        read_capacity      = 2
        projection_type    = "INCLUDE"
        non_key_attributes = ["QuestionId","QuestionTitle","UserId","Status"]
    }

    global_secondary_index {
        name               = "QuestionUserIndex"
        hash_key           = "UserId"
        range_key          = "Status"
        write_capacity     = 2
        read_capacity      = 2
        projection_type    = "INCLUDE"
        non_key_attributes = ["QuestionId","Timestamp","QuestionTitle"]
    }

    tags = {
        Name = "basic-dynamodb-table"
        environment = var.profile
    }
}
