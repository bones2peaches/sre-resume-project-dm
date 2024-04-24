data "aws_iam_policy_document" "logs" {
    depends_on = [ aws_cloudwatch_log_group.this ]
    statement {
      actions = [ "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"]

        effect = "Allow"
        resources = ["arn:aws:logs:${var.region_name}:*:log-group:${var.log_group_name}:*"]
    }
}


resource "aws_iam_policy" "logs" {
  
  name        = "${var.project}-${var.env}-ecs-cluster-log-policy"
  path        = "/"
  description = "Policy that allows ECS tasks to log to CloudWatch Logs"
  policy = data.aws_iam_policy_document.logs.json
}
