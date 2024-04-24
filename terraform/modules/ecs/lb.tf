resource "aws_lb" "this" {
  name                       = "${var.project}-${var.env}-ecs-load-balancer"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.lb_sg_id]
  enable_deletion_protection = false
  # subnets                    = var.lb_subnet_ids

}

resource "aws_lb_target_group" "this" {
  name        = "${var.project}-${var.env}-api-tg"
  port        = var.host_port
  target_type = "ip"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = var.health_check_enabled
    interval            = var.health_check_interval
    path                = var.health_check_path
    port                = var.host_port
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }
}

# Step 5: Create a Listener
resource "aws_lb_listener" "this" {
  depends_on        = [aws_acm_certificate_validation.this]
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate_validation.this.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = aws_lb_listener.this.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    host_header {
      values = ["${var.env}.${var.domain_name}"]
    }
  }
}



