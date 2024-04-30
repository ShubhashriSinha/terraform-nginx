resource "aws_s3_bucket" "alb" {
  bucket = "alb-log-bucket"

  tags = {
    Name        = "main"
    Environment = "Dev"
  }
}