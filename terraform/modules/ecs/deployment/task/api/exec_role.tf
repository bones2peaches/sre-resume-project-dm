


resource "aws_iam_role" "exc_role" {
  name = "${var.project}-${var.env}-${var.app}-ecs-exc-role"

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

resource "aws_iam_role_policy_attachment" "ecs_logs_policy_attachment" {
  depends_on = [aws_iam_policy.logs, aws_iam_role.exc_role]

  role       = "${var.project}-${var.env}-${var.app}-ecs-exc-role"
  policy_arn = aws_iam_policy.logs.arn
}


resource "aws_iam_role_policy_attachment" "exec_attachments" {
  count      = length(var.exec_policies)
  depends_on = [aws_iam_policy.logs, aws_iam_role.exc_role]


  role       = "${var.project}-${var.env}-${var.app}-ecs-exc-role"
  policy_arn = var.exec_policies[count.index]
}

