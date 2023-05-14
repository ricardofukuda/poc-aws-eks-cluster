data "template_file" "ingress_nginx" {
  template = file("config/ingress-nginx.yml")
  vars = {
    sg_id = aws_security_group.nginx_my_ip.id
  }
}

data "http" "icanhazip" { # get my current public ip
   url = "http://icanhazip.com"
}

resource "aws_security_group" "nginx_my_ip" {
  name        = "nginx_my_ip"
  description = "Allow my ip inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["${chomp(data.http.icanhazip.body)}/32"] # restrict to my current public ip
  }

  #ingress {
  #  description      = "http"
  #  from_port        = 80
  #  to_port          = 80
  #  protocol         = "tcp"
  #  cidr_blocks      = ["${chomp(data.http.icanhazip.body)}/32"]
  #}

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "nginx_my_ip"
  }
}

# https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx/4.6.1
resource "helm_release" "ingress-nginx" {
  name       = "ingress-nginx"
  create_namespace = true

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  version    = "4.6.1"

  values = [data.template_file.ingress_nginx.rendered]

  depends_on = [ module.eks ]
}