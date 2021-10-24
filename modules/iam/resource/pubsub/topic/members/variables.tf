variable "topic" {
  description = "The pubsub topic name"
  type        = string
}

variable "project" {
  description = "The ID of the project in which the pubsub resources will be created."
  type        = string
}

variable "iam_bindings" {
  description = "Map of members with a list of roles for each member"
  type        = map(list(string))
  default     = null
}

