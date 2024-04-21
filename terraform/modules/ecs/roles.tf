

resource "aws_iam_role_policy_attachment" "ecs_logs_policy_attachment" {
  depends_on = [ aws_iam_policy.logs ]

  role       = var.exec_role_name
  policy_arn = aws_iam_policy.logs.arn
}


resource "aws_iam_role_policy_attachment" "exec_attachments" {
  count = length(var.exec_policies)



  role       = var.exec_role_name
  policy_arn = var.exec_policies[count.index]
}



