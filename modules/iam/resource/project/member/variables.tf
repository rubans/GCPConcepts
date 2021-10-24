variable "project" {
  type        = string
  description = "The project id for the project"
}

variable "iam_member" {
  description = "IAM member to assign roles"
}

variable "iam_roles" {
  description = "List of roles for the member"
  type        = list(string)
  default     = []
}

variable "audit_configs" {
  description = "A map of services (or allServices) with a list of audit log types for each service"
  type        = map(list(string))
  default     = {}
}