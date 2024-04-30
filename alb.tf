resource "aws_lb" "nginx" {
  name               = "nginx-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nginx.id]
  subnets            = [aws_subnet.public.id, aws_subnet.public.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.alb.id
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "Dev"
  }
}