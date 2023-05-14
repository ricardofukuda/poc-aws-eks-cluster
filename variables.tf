
variable "env" {
  type = string
  default = "dev"
}

variable "vpc" {
  type = object({
    cidr = string
  })

  default = {
    cidr = "11.0.0.0/16"
  }
}

variable "tags" {
  type = any
  default = {
    Cluster = "eks-dev"
    Environment = "dev"
    Terraform = "true"
  }
}