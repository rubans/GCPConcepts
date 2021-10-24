variable "org_id" {
  description = "The organization identifier"
  type        = string
}

variable "iam_method" {
  description = "The method to use to apply IAM permissions - MEMBERS|BINDINGS|POLICY"
  type        = string
  default     = null
}

variable "iam_bindings" {
  description = "Map of members with a list of roles for each member"
  type        = map(list(string))
  default     = {}
}

variable "audit_configs" {
  description = "The audit configs for the project"
  type        = map(list(string))
  default     = {}
}
