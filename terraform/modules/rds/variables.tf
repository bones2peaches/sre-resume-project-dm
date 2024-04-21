variable "env" {
  description = "Environment name."
  type        = string
}

variable "project" {
    description = "prefix for resources for a given project"
    type = string
}


variable "db_port" {
  description = "port for the database"
  type = number
}





variable "db_name" {
  description = "name of the database"
  type = string
}

variable "iam_roles" {
  type = list(string)
  description = "list of iam roles you want to have access to the kms key"
  
}


variable "vpc_id" {
  description = "vpc id for vpces."
  type = string
}

variable "subnet_ids" {
  description = "private subnet ids for postgres subnetgroup"
  type = list(string)
}

variable "sg_id" {
  type = string
  description = "sg for rds"
}

variable "allocated_storage" {
  default = 20
  type = number
}

variable "storage_type" {
  default = "gp2"
  type = string
}

variable "engine"{
  default = "postgres"
  type = string
}

variable "engine_version" {
  default = "15.4"    
  type = string
  
}

variable "instance_class" {
  type = string
  default = "db.t3.micro"

}

variable "db_identifier" {
  type= string
}

variable "db_user" {
  type = string
  default = "postgres"
}

variable "skip_snapshot" {
  default = true
  type = bool
}