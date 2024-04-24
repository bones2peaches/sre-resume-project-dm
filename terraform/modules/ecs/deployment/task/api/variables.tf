variable "env" {
  description = "Environment name."
  type        = string
}

variable "project" {
  description = "prefix for resources for a given project"
  type        = string
}


variable "task_policies" {
  type = list(string)
}

variable "exec_policies" {
  type = list(string)
}



variable "ecr_name" {

}




variable "cpu" {
  default = 2048
  type    = string
}

variable "memory" {
  default = 4096
  type    = string
}

variable "db_name" {

}

variable "db_port" {

}

variable "db_hostname" {

}

variable "host_port" {
  type    = number
  default = 5000
}

variable "container_port" {
  type    = number
  default = 5000
}

variable "rds_secret_arn" {

}

variable "vpc_id" {
  type = string
}

variable "container_name" {
  default = "api"
}



variable "cluster_arn" {

}

variable "health_check_enabled" {
  description = "Whether the health check is enabled for the target group"
  default     = true
}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target"
  default     = 60
}

variable "health_check_path" {
  description = "The destination for the health check request"
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check"
  default     = 5
}

variable "health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering the target unhealthy"
  default     = 2
}




variable "service_subnets" {
  type = list(string)
}








variable "region_name" {

}

variable "log_group_name" {

}



variable "app" {

}

variable "github_sha" {

}

