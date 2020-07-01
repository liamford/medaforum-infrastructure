module "sns_topic" {
    source  = "terraform-aws-modules/sns/aws"
    version = "~> 2.0"
    name  = var.sns
}

module "email_queue" {
    source  = "terraform-aws-modules/sqs/aws"
    version = "~> 2.0"

    name = "email"

    tags = {
        Service     = "email"
        environment = var.profile
    }
}

module "sms_queue" {
    source  = "terraform-aws-modules/sqs/aws"
    version = "~> 2.0"

    name = "sms"

    tags = {
        Service     = "sms"
        environment = var.profile
    }
}

resource "aws_sns_topic_subscription" "event_subscription_email" {
    topic_arn = module.sns_topic.this_sns_topic_arn
    protocol  = "sqs"
    endpoint  = module.email_queue.this_sqs_queue_arn
}

resource "aws_sns_topic_subscription" "event_subscription_sms" {
    topic_arn = module.sns_topic.this_sns_topic_arn
    protocol  = "sqs"
    endpoint  = module.sms_queue.this_sqs_queue_arn
}

resource "aws_sqs_queue_policy" "email_queue_policy" {
    queue_url = module.email_queue.this_sqs_queue_id

    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${module.email_queue.this_sqs_queue_arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${module.sns_topic.this_sns_topic_arn}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sqs_queue_policy" "sms_queue_policy" {
    queue_url = module.sms_queue.this_sqs_queue_id

    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${module.sms_queue.this_sqs_queue_arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${module.sns_topic.this_sns_topic_arn}"
        }
      }
    }
  ]
}
POLICY
}



