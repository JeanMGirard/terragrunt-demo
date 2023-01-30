

variable "vpc_name" {
  type = string
  default = "my-vpc-1"
}
variable "redis_arn" {
  type = string
}
variable "mysql_arn" {
  type = string
}


resource aws_s3_bucket "main" {
  bucket = join("-", [var.vpc_name, "backend"])
}

output "arn" {
  value = aws_s3_bucket.main.arn
}
output "name" {
  value = aws_s3_bucket.main.bucket
}
output "redis_arn" {
  value = var.redis_arn
}
output "mysql_arn" {
  value = var.mysql_arn
}
