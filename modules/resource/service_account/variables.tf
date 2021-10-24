variable "account_id" {
  description = "The name of the service account"
  type        = string
}

variable "display_name" {
  description = "The display name for the service account"
  type        = string
}

variable "description" {
  description = "A description of the service account"
  type        = string
}

variable "project" {
  description = "The project to create the service account in"
  type        = string
}

variable "iam_method" {
  type        = string
  description = "IAM Binding method MEMBER|BINDING|POLICY"
  default     = "MEMBERS"
}

variable "iam_bindings" {
  description = "Map of members with a list of roles for each member"
  type        = map(list(string))
  default     = {}
}

variable "keys" {
  type        = bool
  description = "Change to true to generate keys - best practice is not to use this"
  default     = false
}

