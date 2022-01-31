locals {
  s3_bucket_name = format("my-cloudtrail-%s", var.environment)
  s3_bucket_arn  = format("arn:aws:s3:::%s", local.s3_bucket_name)
}

resource "aws_s3_bucket" "cloudtrail" {
  acl     = "private"
  bucket  = local.s3_bucket_name

  tags = {
    Name        = "My cloudtrail bucket in ${var.environment}"
    Environment = var.environment
  }

  provider = aws.security-admin-us-east-1
}

resource "aws_s3_bucket_policy" "cloudtrail_policy" {
  bucket = aws_s3_bucket.cloudtrail.id
  policy = data.aws_iam_policy_document.cloudtrail_s3_bucket.json

  provider = aws.security-admin-us-east-1
}

resource "aws_s3_bucket_public_access_block" "cloudtrail" {
  bucket                  = aws_s3_bucket.cloudtrail.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  provider = aws.security-admin-us-east-1
}
