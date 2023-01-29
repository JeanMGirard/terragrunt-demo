

variable "bucket_1" {
  type = string
}
variable "bucket_2" {
  type = string
}
variable "bucket_3" {
  type = string
}


output "s3_buckets" {
  value = [
    var.bucket_1,
    var.bucket_2,
    var.bucket_3
  ]
}
