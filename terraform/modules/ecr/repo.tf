




resource "aws_ecr_repository" "this" {
  name = "${var.project}-${var.env}-repo"

  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

}










