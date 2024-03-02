# create application load balancer
resource "aws_lb" "boss-application-load-balancer" {
  name               = "boss-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.boss-alb-security-group.id]
  subnets            = [aws_subnet.boss-privatesubnet1.id, aws_subnet.boss-privatesubnet2.id ]
  enable_deletion_protection = false

  tags   = {
    Name = "boss-alb"
  }
}

# create target group
resource "aws_lb_target_group" "boss-alb-target-group" {
  name        = "boss-alb-tg"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.boss-vpc.id

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}

# create a listener on port 80 with redirect action
resource "aws_lb_listener" "boss-alb-http-listener" {
  load_balancer_arn = aws_lb.boss-application-load-balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# create a listener on port 443 with forward action
resource "aws_lb_listener" "boss-alb-https-listener" {
  load_balancer_arn  = aws_lb.boss-application-load-balancer.arn
  port               = 443
  protocol           = "HTTPS"
  ssl_policy         = "ELBSecurityPolicy-2016-08"
  #certificate_arn    = aws_acm_certificate.boss-acm-cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.boss-alb-target-group.arn
  }
}