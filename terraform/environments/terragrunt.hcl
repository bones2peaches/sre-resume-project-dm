remote_state {
  backend = "s3"
  generate = {
    path      = "state.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "terragrunt-aws-sre"
    key = "resume/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"

  }
}

