


data "aws_iam_policy_document" "sm_kms" {
    depends_on = [ aws_db_instance.this , aws_kms_key.this  ]
    statement {
      actions = [                 "secretsmanager:GetSecretValue",
                "kms:Decrypt",
                "secretsmanager:DescribeSecret",
                "kms:Encrypt"]

        effect = "Allow"
        resources = [                "${aws_db_instance.this.master_user_secret[0].secret_arn}",
                "${aws_kms_key.this.arn}"]
                }
}


resource "aws_iam_policy" "this" {
  
  name        =  "${var.project}-${var.env}-rds-sm-access-policy"
  description = "Policy that allows ECS tasks to access secret and kms for rds"
  policy = data.aws_iam_policy_document.sm_kms.json
}


resource "aws_iam_role_policy_attachment" "this" {
  for_each   = { for idx, arn in var.iam_roles : idx => arn }
  role       = split("/", each.value)[length(split("/", each.value)) - 1]
  policy_arn = aws_iam_policy.this.arn
}




