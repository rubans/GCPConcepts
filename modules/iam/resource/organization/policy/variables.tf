variable "org_id" {
  description = "The organisation id"
  type        = number
}

variable "iam_bindings" {
  description = "Map of members with a list of roles for each member"
  type        = map(list(string))
}

variable "audit_configs" {
  description = "The audit configs for the project"
  type        = map(list(string))
}
