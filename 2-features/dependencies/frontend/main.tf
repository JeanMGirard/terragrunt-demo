



resource aws_s3_bucket "main" {
  bucket = "frontend"
}

output "arn" {
  value = aws_s3_bucket.main.arn
}
output "name" {
  value = aws_s3_bucket.main.bucket
}
