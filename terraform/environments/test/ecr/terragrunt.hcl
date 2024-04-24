terraform {
  source = "../../../../terraform/modules/ecr"
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
  iam_roles = [dependency.runner.outputs.role_arn]
  env             = include.env.locals.env
  project         = "sredevops"
  repo = dependency.repo.outputs.repo_name  
  
}




dependency "runner" {
  config_path = "../../shared/github/runner"

}

dependency "repo" {
  config_path = "../../shared/github/repository"

}

