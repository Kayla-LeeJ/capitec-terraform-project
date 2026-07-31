output "bucket_name" {
  description = "Name of the S3 backend bucket"
  value       = aws_s3_bucket.jansmakl-s3-backend.id
}

output "bucket_arn" {
  description = "ARN of the S3 backend bucket"
  value       = aws_s3_bucket.jansmakl-s3-backend.arn
}
