output "db_instance_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "db_hostname" {
  value = split(":", aws_db_instance.this.endpoint)[0]
}

output "db_port" {
  value = var.db_port
}

output "db_user" {
  value = var.db_user
}

output "db_name" {
  value = var.db_name
}

output "db_instance_secret_arn" {
  value       = aws_db_instance.this.master_user_secret[0].secret_arn
  description = "The ARN of the secret associated with the RDS instance"
}

output "secret_arn" {
  value = aws_db_instance.this.master_user_secret[0].secret_arn 
}

output "kms_arn" {
  value = aws_kms_key.this.arn
} 

output "kms_sm_policy_arn"{
  value = aws_iam_policy.this.arn
}