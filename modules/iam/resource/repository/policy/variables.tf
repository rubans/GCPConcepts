variable "repository" {
  description = "The name of the csr repository"
  type        = string
}

variable "iam_bindings" {
  description = "Map of members with a list of roles for each member"
  type        = map(list(string))
}

