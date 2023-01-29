


output "s3_bucket_arn" {
  value = aws_s3_bucket.main.arn
}
output "meta" {
  value = var.meta
}
