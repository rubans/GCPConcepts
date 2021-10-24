variable "account_id" {
  description = "The fully qualified service account name"
  type        = string
}

variable "iam_bindings" {
  description = "Map of members with a list of roles for each member"
  type        = map(list(string))
}
