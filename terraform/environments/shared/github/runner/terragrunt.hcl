terraform {
  source = "../../../../modules/ec2/runner"
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

  region_name = "us-east-1"
  instance_name ="sre-self-hosted"
  key_pair_name = "self-hosted-kp"
  ami_id = "ami-07d9b9ddc6cd8dd30"
  instance_size = "t2.medium"
  role_name = "sre-github-actions-self-hosted-role"
  policy_name = "sre-github-actions-self-hosted-s3-ecr-policy"
  sg_name = "sre-github-actions-self-hosted-sg"
  vpc_id = dependency.vpc.outputs.vpc_id
  subnet_id = dependency.vpc.outputs.public_subnet_ids[0]
  bucket_name = "terragrunt-aws-sre"
  token_path = "resume/shared/github/repository/terraform.tfstate"
  svn_url = dependency.repo.outputs.svn_url
  repo = dependency.repo.outputs.repo_name
  
}

dependency "vpc" {
  config_path = "../../vpc"

}

dependency "repo" {
  config_path = "../repository"

}


