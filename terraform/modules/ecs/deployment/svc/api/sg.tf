resource "aws_security_group" "this" {
  name        = "${var.project}-${var.env}-${var.app}-sg"
  description = "sg for ${var.app}"
  vpc_id      = var.vpc_id


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}