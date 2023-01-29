

variable "secret_data" {
  type = any
  default = {}
}

output "secret_data" {
  value = var.secret_data
}
