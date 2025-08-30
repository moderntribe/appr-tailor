resource "aws_security_group" "web_server" {
  name_prefix = local.tailor_name
  vpc_id      = local.network_info.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.tailor_name
  }
}

# Application Load Balancer
resource "aws_lb" "tailor_lb" {
  name               = local.tailor_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_server.id]
  subnets            = local.network_info.public_subnets

  enable_deletion_protection = false

  tags = {
    Name = "appr-tailor-${var.environment}"
  }
}

resource "aws_lb_target_group" "tailor_tg" {
  name        = local.tailor_name
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = local.network_info.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/healthcheck"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name        = local.tailor_name
    Environment = var.environment
  }
}

resource "aws_lb_listener" "tailor_listener_https" {
  load_balancer_arn = aws_lb.tailor_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.tailor_acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tailor_tg.arn
  }
}

resource "aws_lb_listener" "tailor_listener_http" {
  load_balancer_arn = aws_lb.tailor_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
