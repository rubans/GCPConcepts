variable "domain" {
  type        = string
  description = "The domain for the organisation"
}

variable "iam_method" {
  type        = string
  description = "IAM Binding method MEMBER|BINDING|POLICY"
  default     = "MEMBER"
}

variable "iam_bindings" {
  description = "Map of members with a list of roles for each member"
  type        = map(list(string))
  default     = {}
}

variable "audit_configs" {
  description = "A map of audit configurations"
  type        = map(list(string))
  default     = {}
}
