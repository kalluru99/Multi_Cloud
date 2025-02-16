# Replace with your desired regions
provider "aws" {
  region = "us-east-2"
}

# Configure the random provider
provider "random" {}

# Generate a random string for uniqueness
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Create an S3 bucket with a unique name
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-${random_string.bucket_suffix.result}"

  tags = {
    Name        = "My unique bucket"
    Environment = "Dev"
  }
}

# Output the bucket name
output "bucket_name" {
  value       = aws_s3_bucket.my_bucket.id
  description = "The name of the S3 bucket"
}