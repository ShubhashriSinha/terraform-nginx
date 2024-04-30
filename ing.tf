resource "aws_internet_gateway" "nginx_ing" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}