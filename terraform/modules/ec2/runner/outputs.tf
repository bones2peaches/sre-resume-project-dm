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