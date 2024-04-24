terraform {
  source = "../../../../../../modules/ecs/deployment/svc/api"
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
  env               = include.env.locals.env
  repo = dependency.repo.outputs.repo_name
  project         = "sredevops"  

}

dependency "repo" {
  config_path = "../../../shared/github/repository"

}
