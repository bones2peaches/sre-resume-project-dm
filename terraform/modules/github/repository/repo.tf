resource "github_repository" "this" {
  name        = var.repo
  description = var.description

  visibility = var.vis

}