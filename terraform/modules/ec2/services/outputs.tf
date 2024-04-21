output "private_key" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}

output "instance_ip" {
    value = aws_instance.this.public_ip
}

output "instance_id" {
    value = aws_instance.this.id
}

output "role_name" {
  value = var.role_name
}

output "role_arn" {
  value = aws_iam_role.this.arn
}

output "sg_id" {
  value = aws_security_group.this.id
}

output "subnet_id" {
  value = var.subnet_id
}