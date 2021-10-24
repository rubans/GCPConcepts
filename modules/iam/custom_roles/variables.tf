variable "source_role" {
  description = "The role identifier to be copied"
  type = string
}

variable "role_id" {
  descrition = "The role identifier for the custom role"
  type = string
}

variable "title" {
  description = "The title for the custom role"
  type = string
}

variable "description" {
  description = "The description for the custom role"
  type = string
  default = null
}

variable "org_id" {
  description = "The organization identifier"
  type = string
}

variable "remove_permissions" {
  description = "A list of permissions to remove from the role"
  default = []
}

variable "additional_permissions" {
  description = "A list of additional permissions to assign the role"
  default = []
}

