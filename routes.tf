resource "aws_route_table" "nginx" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = aws_vpc.main.cidr_block
    gateway_id = aws_internet_gateway.nginx_ing.id
  }

  tags = {
    Name = "main"
  }
}

resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.nginx.id
}