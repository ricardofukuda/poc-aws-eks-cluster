variable "env" {
  type = string
  default = "dev"
}

variable "tags" {
  type = any
  default = {
    App = "k8s-dashboard"
    Environment = "dev"
    Terraform = "true"
  }
}
