variable "region_name" {
    type = string
}

variable "instance_name" {
    type = string
}

variable "key_pair_name" {
    type = string
}

variable "ami_id" {
    type = string
}

variable "instance_size" {
    type = string
}

variable "role_name" {
    type = string
}

variable "policy_name" {
    type = string
}

variable "sg_name" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "subnet_id" {

}

variable "bucket_name" {
    type = string
    description = "state bucket to pull the token for"
}

variable "token_path" {
    type = string
    description = "path of the state where the token is stored"
}

variable "svn_url" {
    type = string
}

variable "repo" {
    type = string
    
}


variable "security_group_rules_path" {
  type = string
}

variable "source_sg_id" {
  
}

