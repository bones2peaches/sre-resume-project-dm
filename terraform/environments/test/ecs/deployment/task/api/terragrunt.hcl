terraform {
  source = "../../../../../../modules/ecs/deployment/task/api"
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
  project         = "sredevops"  
  exec_policies = [dependency.ecr.outputs.pull_policy_arn , dependency.rds.outputs.kms_sm_policy_arn ]
  task_policies = []
  ecr_name = dependency.ecr.outputs.ecr_name

  db_port         = dependency.rds.outputs.db_port
  db_name         = "postgres"
  db_hostname = dependency.rds.outputs.db_hostname
  rds_secret_arn = dependency.rds.outputs.secret_arn
  vpc_id = dependency.vpc.outputs.vpc_id
  container_name = "api"
  app = "api"
  cluster_arn =  dependency.cluster.outputs.cluster_arn
  service_subnets = dependency.vpc.outputs.public_subnet_ids
  log_group_name = dependency.cluster.outputs.log_group_name
  region_name = "us-east-1"


  
  health_check_interval = 60
  health_check_path = "/api/health"

}


dependency "ecr" {
    config_path = "../../../../ecr"
}

dependency "rds" {
    config_path = "../../../../rds"
}

dependency "vpc" {
    config_path = "../../../../../shared/vpc"
}

dependency "cluster" {
    config_path = "../../../../ecs/cluster"
}

