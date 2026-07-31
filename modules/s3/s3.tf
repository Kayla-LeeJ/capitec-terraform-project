#--------------------------------#
# Module: S3
#--------------------------------#
#Resource: aws_s3_bucket
resource "aws_s3_bucket" "jansmakl-s3-backend" {
  bucket        = "${var.prefix}-${var.resource}-backend"
  force_destroy = false

  tags = merge(local.default_tags, {
    Name = "${var.prefix}-${var.resource}-backend"
  })

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags]
  }
}

resource "aws_s3_bucket_versioning" "jansmakl-s3-backend" {
  bucket = aws_s3_bucket.jansmakl-s3-backend.id
  versioning_configuration {
    status = "Enabled"
  }
}