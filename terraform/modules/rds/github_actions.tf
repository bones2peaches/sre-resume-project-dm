resource "github_actions_environment_secret" "db_user" {
  

  repository       = var.repo
  environment      = var.env_name
  secret_name      = "DB_USER"
  plaintext_value            = var.db_user
}

resource "github_actions_environment_secret" "db_port" {
  

  repository       = var.repo
  environment      = var.env_name
  secret_name      = "DB_PORT"
  plaintext_value            = var.db_port
}

resource "github_actions_environment_secret" "db_host" {
  

  repository       = var.repo
  environment      = var.env_name
  secret_name      = "DB_HOST"
  plaintext_value            = split(":", aws_db_instance.this.endpoint)[0]
}

resource "github_actions_environment_secret" "db_secret_arn" {
  

  repository       = var.repo
  environment      = var.env_name
  secret_name      = "DB_SECRET_ARN"
  plaintext_value            = aws_db_instance.this.master_user_secret[0].secret_arn
}

resource "github_actions_environment_secret" "db_name" {
  

  repository       = var.repo
  environment      = var.env_name
  secret_name      = "DB_NAME"
  plaintext_value            = var.db_name
}

