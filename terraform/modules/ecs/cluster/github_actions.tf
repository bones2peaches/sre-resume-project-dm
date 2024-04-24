resource "github_actions_environment_secret" "arn" {
  

  repository       = var.repo
  environment      = var.env
  secret_name      = "CLUSTER_ARN"
  plaintext_value            = aws_ecs_cluster.this.arn
}

resource "github_actions_environment_secret" "id" {
  

  repository       = var.repo
  environment      = var.env
  secret_name      = "CLUSTER_ID"
  plaintext_value            = aws_ecs_cluster.this.id
}

resource "github_actions_environment_secret" "log_group_name" {
  

  repository       = var.repo
  environment      = var.env
  secret_name      = "LOG_GROUP_NAME"
  plaintext_value            = "${var.project}-${var.env}-log-group"
}