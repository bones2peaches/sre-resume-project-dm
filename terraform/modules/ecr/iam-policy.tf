
data "aws_iam_policy_document" "iam" {


      statement {
 
    actions   = [         "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",


        ]

    effect = "Allow"
    resources = ["*"]
  }


}


resource "aws_iam_policy" "this" {
  name = "${var.project}-${var.env}-pull-image-policy"

  policy = data.aws_iam_policy_document.iam.json
}