terraform {
  source = "../../../../modules/github/environment"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  env_name                = include.env.locals.env
  github_user = "bones2peaches"
  repo = dependency.repo.outputs.repo_name
  branch_pattern = "feature-*"
}

dependency "repo" {
  config_path = "../../../shared/github/repository"

}
