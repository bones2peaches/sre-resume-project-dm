output "exec_role_name" {
  value = aws_iam_role.exc_role.name
}

output "exec_role_arn" {
  value = aws_iam_role.exc_role.arn
}

output "task_role_name" {
  value = aws_iam_role.task_role.name
}

output "task_role_arn" {
  value = aws_iam_role.task_role.arn
}