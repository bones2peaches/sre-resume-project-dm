resource "aws_cloudwatch_log_group" "this" {
  name = "${var.project}-${var.env}-log-group"
}