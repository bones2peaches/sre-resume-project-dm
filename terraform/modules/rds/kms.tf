data "aws_iam_policy_document" "kms" {


  statement {
    effect = "Allow"
    actions = ["kms:*"]
    resources = ["*"]
    principals {
           type = "AWS"
     identifiers =["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"  , "${data.aws_caller_identity.current.arn}" ]
     }
  }




  statement {
    principals {
     type = "AWS"
     identifiers =["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" ,"${data.aws_caller_identity.current.arn}"] 
      }
    condition {
      test = "Bool"
      values = [true]
      variable = "kms:GrantIsForAWSResource"
    }      
    
    actions   = [                 "kms:CreateGrant",
                "kms:ListGrants",
                "kms:RevokeGrant"]
    resources = ["*"]
    effect = "Allow"

  }

  statement {
    principals {
     type = "AWS"
     identifiers =var.iam_roles
      }
    actions   = [                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"]
    resources = ["*"]
    effect = "Allow"
  }
}



resource "aws_kms_key" "this" {
  policy = data.aws_iam_policy_document.kms.json
}

