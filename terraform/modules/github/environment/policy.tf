# resource "github_repository_deployment_branch_policy" "feature_branch_policy" {
#   depends_on = [github_repository_environment.this]

#   repository       = var.repo
#   environment_name = var.env_name
#   name             = var.branch_pattern
# }

resource "github_repository_environment_deployment_policy" "this" {
  repository        = var.repo
  environment       = var.env_name
  branch_pattern = var.branch_pattern
}