terraform {
  source = "../../../../modules/github/repository"
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

  repo = "sre-resume-project-dm"

}

