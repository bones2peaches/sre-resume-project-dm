






resource "aws_iam_role" "task_role" {
  name = "${var.project}-${var.env}-ecs-task-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "tasks_attachments" {
  count      = length(var.exec_policies)
  depends_on = [aws_iam_role.task_role]


  role       = "${var.project}-${var.env}-ecs-task-role"
  policy_arn = var.exec_policies[count.index]
}
