variable "security_group_rules_content" {
  type = string
}

locals {
  security_group_rules = yamldecode(var.security_group_rules_content)
}



resource "aws_security_group" "this" {
  name        = "${var.sg_name}"
  description = "Allow all ssh traffic for ec2 instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "this" {
  for_each          = { for rule in local.security_group_rules : "${rule.from_port}-${rule.to_port}-${rule.protocol}" => rule }
  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  security_group_id = aws_security_group.this.id
  source_security_group_id = var.source_sg_id
}
