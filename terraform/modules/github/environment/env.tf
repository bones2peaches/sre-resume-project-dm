
resource "github_repository_environment" "this" {
  environment         = var.env_name
  repository          = var.repo
  can_admins_bypass = var.admin_bypass   
  prevent_self_review = var.prevent_self_review


  deployment_branch_policy {
    protected_branches     = var.protected_branches
    custom_branch_policies = var.custom_branch_policies
  }
}