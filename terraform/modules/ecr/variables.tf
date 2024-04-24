variable "env" {
  description = "Environment name."
  type        = string
}

variable "project" {
    description = "prefix for resources for a given project"
    type = string
}

variable "scan_on_push" {
  type = bool
  default = true
}

variable "iam_roles" {
  description = "iam roles that can push and pull from repo"
  type = list(string)
}

variable "repo" {
  
}