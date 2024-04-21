variable "repo" {
    type = string
    description = "name of the github reporsitory"
}


variable "description" {
    type = string
    default = "resume project for sre encompasing frontend development, backend development, network engineer, test developement and ci/cd."
  
}

variable "vis" {
  default = "public"
}