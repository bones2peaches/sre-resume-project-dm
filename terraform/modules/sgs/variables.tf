variable "env" {
  description = "Environment name."
  type        = string
}

variable "project" {
    description = "prefix for resources for a given project"
    type = string
}


variable "db_port" {
  type  = number
}

variable "app_port" {
  type = number
}


variable "vpc_id" {
  description = "vpc id for vpces."
  type = string
}



