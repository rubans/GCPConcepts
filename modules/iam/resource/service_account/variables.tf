variable "account_id" {
  description = "The name of the service account"
  type        = string
}

variable "iam_method" {
  description = "The method to use to apply IAM permissions - MEMBERS|BINDINGS|POLICY"
  type        = string
}

variable "iam_bindings" {
  description = "Map of members with a list of roles for each member"
  type        = map(list(string))
}

