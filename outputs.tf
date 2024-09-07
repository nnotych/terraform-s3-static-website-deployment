output "s3_bucket_website_url" {
  value = aws_s3_bucket.bucket.website_endpoint
  description = "The URL of the S3 static website."
}
