resource "aws_lb" "nginx" {
  name               = "nginx-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nginx.id]
  subnets            = [aws_subnet.public.id, aws_subnet.public.id]
  enable_cross_zone_load_balancing = true

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

resource "aws_lb_target_group" "nginx_a" { 
 name     = "nginx-target-group"
 port     = 80
 protocol = "HTTP"
 vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group_attachment" "nginx_tg_attachment_a" {
 count = length(aws_instance.nginx)
 target_group_arn = aws_lb_target_group.nginx_a.arn
 target_id        = aws_instance.nginx[count.index].id
 port             = 80
}

resource "aws_lb_listener" "nginx" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn" //cert goes here

 default_action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.nginx_a.arn
 }

  depends_on = [
    aws_lb.nginx
  ]

  lifecycle {
      create_before_destroy = false
    }
}
