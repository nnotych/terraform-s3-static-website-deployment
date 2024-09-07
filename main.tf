##### Creating a Random String #####
resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
} 

# Create an S3 bucket
resource "aws_s3_bucket" "bucket" {
  bucket        = "my-static-website-bucket-${random_string.random.result}" # Replace with your desired bucket name
  force_destroy = true  # Allows deletion of the bucket even if it contains objects
}
##### Configure the S3 bucket as a static website #####
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

##### Allow public access to the S3 bucket #####
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

##### Upload Files to S3 #####
resource "aws_s3_object" "upload_object" {
  for_each      = fileset("website/", "**/*")
  bucket        = aws_s3_bucket.bucket.id
  key           = each.value
  source        = "website/${each.value}"
  etag          = filemd5("website/${each.value}")
  content_type  = lookup({
    "html" = "text/html",
    "css"  = "text/css",
    "png"  = "image/png",
    "jpg"  = "image/jpeg",
    "ico"  = "image/x-icon"
  }, split(".", each.value)[length(split(".", each.value)) - 1], "text/plain")
}

##### Adding a Bucket Policy for Public Access #####
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "PublicReadGetObject",
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetObject",
        Resource = "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}/*"
      }
    ]
  })
}

