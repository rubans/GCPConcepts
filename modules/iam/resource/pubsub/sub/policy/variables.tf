variable "project" {
  description = "The ID of the project in which the pubsub resources will be created."
  type        = string
}

variable "subscription_name" {
  description = "The name of pubsub subscription"
  type        = string
}

variable "iam_bindings" {
  description = "Map of members with a list of roles for each member"
  type        = map(list(string))
}

