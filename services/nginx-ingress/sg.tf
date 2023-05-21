resource "aws_security_group" "nginx_my_ip" {
  name        = "nginx_my_ip"
  description = "Allow my ip inbound traffic"
  vpc_id      = data.aws_vpc.vpc.id

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
