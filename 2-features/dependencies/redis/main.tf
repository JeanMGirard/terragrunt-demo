

variable "vpc_name" {
  type = string
  default = "my-vpc-1"
}

resource aws_s3_bucket "main" {
  bucket = join("-", [var.vpc_name, "redis"])
}

output "arn" {
  value = aws_s3_bucket.main.arn
}
output "name" {
  value = aws_s3_bucket.main.bucket
}
