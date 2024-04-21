resource "aws_security_group" "this" {
  name        = "${var.project}-${var.env_name}-rds-sg"
  description = "Allow all ssh traffic for ec2 instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "PG ACCESS FROM GITHUB RUNNER"
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    security_groups = [var.sg_id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}