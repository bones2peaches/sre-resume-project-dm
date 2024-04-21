variable "repo" {
    type = string
    description = "name of the github reporsitory"
}

variable "github_user" {
  type = string
  description = "username of the github user"
}


variable "env_name" {
    type = string
    description = "name of the env"
}

variable "admin_bypass" {
    type = bool
    description = "not sure"
    default = true
}

variable "prevent_self_review" {
  type = bool
  default = true
}

variable "protected_branches" {
    type = bool
    default = false
  
}

variable "custom_branch_policies" {
    type = bool
    default = true

}

variable "branch_pattern" {
    type = string

  
}

