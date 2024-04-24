terraform {
  source = "../../../modules/public_hosted_zone"
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

    domain_name = "bones2peaches.com"
}



