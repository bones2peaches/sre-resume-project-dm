variable "repo" {
  type = string
}

variable "allowed_actions" {
  type = string
  default = "all"
}

variable "env_name" {
  type = string

}


variable "environment_variables" {
    type = map(string)


}

variable "environment_secrets" {
    type = map(string)
    
}