resource "aws_instance" "nginx" {
  ami = ""
  instance_type = "t2.micro"
  count = 2
  tags = {
    Name = "nginx"
  }
  subnet_id = aws_subnet.private.id
  security_groups = [aws_security_group.nginx.id]
  user_data = <<EOF
    #! /bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF
}