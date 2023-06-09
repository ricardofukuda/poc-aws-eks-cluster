variable "env" {
  type = string
  default = "dev"
}

variable "tags" {
  type = any
  default = {
    App = "nginx-ingress"
    Environment = "dev"
    Terraform = "true"
  }
}