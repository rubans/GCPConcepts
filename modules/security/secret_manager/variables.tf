variable "prefix" {
  description = "The string used to prefix resources within this folder. Considered to be the cost owner of all resources in said folder."
  type        = string
}

variable "project" {
  description = "The ID of the project in which the resource will be created. Considered the owner of the resources."
  type        = string
}

variable "env" {
  description = "The environment the resource is in"
  type        = string
}

variable "description" {
  description = "What the resource is for. Backend, frontend, etc"
  type        = string
}

variable "labels" {
  description = "Labels (in addition to the defaults)"
  type        = map(string)
  default     = {}
}
