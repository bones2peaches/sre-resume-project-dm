
data "aws_iam_policy_document" "ecr" {
    statement {
      effect = "Allow"
        principals {
        type        = "Service"
        identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = [        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"]
    }

    statement {
      effect = "Allow"
        principals {
        type        = "Service"
        identifiers = ["ec2.amazonaws.com"]
    }
    actions = [        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"]
    }

      statement {
    principals {
     type = "AWS"
     identifiers =var.iam_roles
      }
    actions   = [        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload"]

    effect = "Allow"
  }


}


resource "aws_ecr_repository_policy" "this" {
  repository = aws_ecr_repository.this.name

  policy = data.aws_iam_policy_document.ecr.json
}