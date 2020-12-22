resource "aws_cloudtrail" "medaforum-cloudtrail" {
    name = "medaforum-cloudtrail"
    s3_bucket_name = "${aws_s3_bucket.s3_cloudtrail_name.id}"
    include_global_service_events = true
    is_multi_region_trail = true
    enable_log_file_validation = true
}

resource "aws_s3_bucket" "s3_cloudtrail_name" {
    bucket = "medaforum-cloudtrail-bucket"

    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
{
   "Sid": "AWSCloudTrailAclCheck",
   "Effect": "Allow",
   "Principal": {
      "Service": "cloudtrail.amazonaws.com"
},
 "Action": "s3:GetBucketAcl",
 "Resource": "arn:aws:s3:::medaforum-cloudtrail-bucket"
},
{
"Sid": "AWSCloudTrailWrite",
"Effect": "Allow",
"Principal": {
  "Service": "cloudtrail.amazonaws.com"
},
"Action": "s3:PutObject",
"Resource": "arn:aws:s3:::medaforum-cloudtrail-bucket/*",
"Condition": {
  "StringEquals": {
     "s3:x-amz-acl": "bucket-owner-full-control"
  }
}
  }
  ]
  }
  POLICY
}
