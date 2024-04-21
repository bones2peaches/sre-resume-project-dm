
resource "github_actions_repository_permissions" "this" {
  allowed_actions = var.allowed_actions
  repository = var.repo
}