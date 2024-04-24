resource "github_actions_environment_secret" "ecr_name" {
  

  repository       = var.repo
  environment      = var.env
  secret_name      = "ECR_NAME"
  plaintext_value            = "${var.project}-${var.env}-repo"

}