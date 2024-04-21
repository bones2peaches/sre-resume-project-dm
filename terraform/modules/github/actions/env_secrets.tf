resource "github_actions_environment_secret" "this" {
  for_each = var.environment_secrets

  repository       = var.repo
  environment      = var.env_name
  secret_name      = each.key
  plaintext_value            = each.value
}