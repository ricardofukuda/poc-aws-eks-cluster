variable "env" {
  type = string
  default = "dev"
}

variable "tags" {
  type = any
  default = {
    App = "airflow"
    Environment = "dev"
    Terraform = "true"
  }
}