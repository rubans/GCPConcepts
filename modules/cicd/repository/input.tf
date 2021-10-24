variable "name" {
  type        = string
  description = "The csr repository name"
}

variable "project" {
  description = "The project that owns the repository"
}

variable "module_depends_on" {
  type        = any
  default     = []
  description = "Module dependency variable"
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