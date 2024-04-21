output "vpce_sg_id" {
  value = aws_security_group.vpce.id
}

output "rds_sg_id" {
  value = aws_security_group.rds.id
}

output "lb_sg_id" {
  value = aws_security_group.lb.id
}


output "svc_sg_id" {
  value = aws_security_group.svc.id
}