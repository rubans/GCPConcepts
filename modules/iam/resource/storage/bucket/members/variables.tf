variable "bucket_name" {
  description = "The bucket name"
  type        = string
}

variable "iam_bindings" {
  description = "Map of members with a list of roles for each member"
  type        = map(list(string))
  default     = null
}
