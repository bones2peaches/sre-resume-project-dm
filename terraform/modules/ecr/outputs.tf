output "ecr_id" {
  value = aws_ecr_repository.this.registry_id
}

output "ecr_arn" {
  value = aws_ecr_repository.this.arn
}

output "ecr_url" {
  value = aws_ecr_repository.this.repository_url
}

output "ecr_name" {
  value = aws_ecr_repository.this.name
}

output "pull_policy_arn"{
  value = aws_iam_policy.this.arn
}