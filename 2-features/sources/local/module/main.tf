

output "example_output" {
  value = "this is an example"
}

variable "paths" {
  type = map(string)
  default = {}
}

output "paths" {
  value = var.paths
}
