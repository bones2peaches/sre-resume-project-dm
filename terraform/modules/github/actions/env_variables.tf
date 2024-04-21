resource "github_actions_environment_variable" "this" {
  for_each = var.environment_variables

  repository       = var.repo
  environment      = var.env_name
  variable_name    = each.key
  value            = each.value
}