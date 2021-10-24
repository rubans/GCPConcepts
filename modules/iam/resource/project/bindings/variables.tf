variable "project" {
  description = "The project id"
  type        = string
}

variable "iam_bindings" {
  description = "Map of members with a list of roles for each member"
  type        = map(list(string))
  default     = null
}

variable "audit_configs" {
  description = "A map of services (or allServices) with a list of audit log types for each service"
  type        = map(list(string))
  default     = null
}
