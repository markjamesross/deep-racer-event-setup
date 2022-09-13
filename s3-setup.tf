#Create bucket for submitted models
resource "aws_s3_bucket" "models" {
  bucket = "deepracer-models-${data.aws_caller_identity.current.account_id}"
  tags = {
    Name = var.service_name
  }
}
#Attache bucket policy
resource "aws_s3_bucket_policy" "models" {
  bucket = aws_s3_bucket.models.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}
#Apply versioning
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.models.id
  versioning_configuration {
    status = "Disabled"
  }
}
#Apply ACL
resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.models.id
  acl    = "private"
}
#Apply SSE
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.models.id
  rule {
    bucket_key_enabled = true
    apply_server_side_encryption_by_default {
      #Use S3 key
      sse_algorithm = "aws:kms"
    }
  }
}
#Apply security public blocking settings
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.models.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#Data object to create S3 bucket policy
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid    = "DenyInsecureTransport"
    effect = "Deny"
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::deepracer-models-${data.aws_caller_identity.current.account_id}",
      "arn:aws:s3:::deepracer-models-${data.aws_caller_identity.current.account_id}/*"
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false"
      ]
    }
  }
}

#Create folder with placeholder for each participant
resource "aws_s3_object" "object" {
  for_each = var.deep_racer_participants
  bucket   = aws_s3_bucket.models.id
  key      = "${each.key}/ReadMe.txt"
  source   = "s3/ReadMe.txt"
}