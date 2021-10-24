variable "project" {
  description = "The ID of the project in which the pubsub resources will be created."
  type        = string
  default     = null
}

variable "subscription_name" {
  description = "The folder name of pubsub topic"
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
