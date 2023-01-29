

variable "bucket_name" {
  type = string
  default = "my-bucket-735"
}

resource aws_s3_bucket "main" {
  bucket = var.bucket_name
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.main.arn
}
