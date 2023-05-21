variable "env" {
  type = string
  default = "dev"
}

variable "tags" {
  type = any
  default = {
    Environment = "dev"
    Terraform = "true"
  }
}
