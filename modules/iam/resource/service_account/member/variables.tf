variable "service_account_id" {
  description = "The fully qualified account name for the service account"
  type        = string
}

variable "iam_member" {
  description = "The member to assign roles"
  type        = string
}

variable "iam_roles" {
  description = "A list of roles to assign to the member"
  type        = list(string)
  default     = []
}
