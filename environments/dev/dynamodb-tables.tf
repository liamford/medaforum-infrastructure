resource "aws_dynamodb_table" "question-table" {
    name           = "Questions"
    billing_mode   = "PROVISIONED"
    read_capacity  = 2
    write_capacity = 2
    hash_key       = "QuestionId"

    attribute {
        name = "QuestionId"
        type = "S"
    }


    attribute {
        name = "Timestamp"
        type = "N"
    }

    attribute {
        name = "UserId"
        type = "S"
    }

    attribute {
        name = "DoctorId"
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


    global_secondary_index {
        name               = "QuestionStatusIndex"
        hash_key           = "Status"
        range_key          = "Timestamp"
        write_capacity     = 2
        read_capacity      = 2
        projection_type    = "INCLUDE"
        non_key_attributes = ["QuestionId","QuestionTitle","User","GeneralQuestions","DoctorId","QuestionGroup","Answer"]
    }

    global_secondary_index {
        name               = "QuestionGroupIndex"
        hash_key           = "QuestionGroup"
        range_key          = "Timestamp"
        write_capacity     = 2
        read_capacity      = 2
        projection_type    = "INCLUDE"
        non_key_attributes = ["QuestionId","QuestionTitle","UserId","Status","User","QuestionGroup","Answer","GeneralQuestions","MoreInformation","DoctorId"]
    }

    global_secondary_index {
        name               = "QuestionUserIndex"
        hash_key           = "UserId"
        range_key          = "Status"
        write_capacity     = 2
        read_capacity      = 2
        projection_type    = "INCLUDE"
        non_key_attributes = ["QuestionId","Timestamp","QuestionTitle","QuestionGroup","User"]
    }

    global_secondary_index {
        name               = "QuestionDoctorIndex"
        hash_key           = "DoctorId"
        range_key          = "Status"
        write_capacity     = 2
        read_capacity      = 2
        projection_type    = "INCLUDE"
        non_key_attributes = ["QuestionId","Timestamp","QuestionTitle","QuestionGroup","User"]
    }

    tags = {
        Name = "question-table"
        environment = var.profile
    }
}
