resource "aws_lb_target_group" "this" {
  name        = "${var.project}-${var.env}-${var.app}-tg"
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