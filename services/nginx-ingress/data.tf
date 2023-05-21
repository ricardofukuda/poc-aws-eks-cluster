data "aws_eks_cluster" "eks" {
  name = "eks-${var.env}"
}

data "aws_eks_cluster_auth" "eks_auth" {
  name =  data.aws_eks_cluster.eks.name
}

data "aws_vpc" "vpc"{
  tags = {
    Name = "eks-${var.env}"
  }
}

data "template_file" "values" {
  template = file("config/values.yml")
  vars = {
    sg_id = aws_security_group.nginx_my_ip.id
  }
}

data "http" "icanhazip" { # get my current public ip
   url = "http://icanhazip.com"
}