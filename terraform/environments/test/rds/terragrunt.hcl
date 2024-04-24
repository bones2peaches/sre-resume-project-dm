terraform {
  source = "../../../../terraform/modules/rds"
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
  repo = dependency.repo.outputs.repo_name
  env             = include.env.locals.env
  project         = "sredevops"
  db_port         = 6000
  db_name         = "testdb"
  iam_roles       = [dependency.runner.outputs.role_arn]
  vpc_id          =dependency.vpc.outputs.vpc_id
  subnet_ids      = dependency.vpc.outputs.public_subnet_ids
  sg_id           =  dependency.runner.outputs.sg_id
  db_identifier  = "teststr"
  db_user           = "testapiuser"
}


dependency "vpc" {
  config_path = "../../shared/vpc"

}

dependency "runner" {
  config_path = "../../shared/github/runner"

}

dependency "repo" {
  config_path = "../../shared/github/repository"

}