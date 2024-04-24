# output "sg_id" {
#   value = aws_security_group.this.id
# }

# output "tg_arn" {
#   value = aws_lb_target_group.this.arn
# }

output "latest_task_arn" {
  value       = aws_ecs_task_definition.this.arn
  description = "The ARN of latest api arn"
}


