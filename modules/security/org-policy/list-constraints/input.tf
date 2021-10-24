variable "org_id" {
  description = "organization id"
  type        = string
}

variable "enable" {
  description = "Enable the constraint"
  type    = bool
  default = false
}

variable "constraint" {
  description = "The constraint to be applied"
  type        = string
}

variable "policy_level" {
  description = "Resource hierarchy node to apply the policy to(org,folder or project)"
  type        = string
}

variable "folder_id" {
  description = "The folder id for putting the policy"
  type        = string
  default     = null
}

variable "project_id" {
  description = "The project id for putting the policy"
  type        = string
  default     = null
}

variable "allow_all_constraint" {
  description = "For list constraint, whether to allow all (true) or deny all"
  type        = bool
  default     = null
}

variable "allow_list" {
  description = "List of values which should be allowed"
  type        = list(string)
  default     = [""]
}

variable "deny_list" {
  description = "List of values which should be denied"
  type        = list(string)
  default     = [""]
}

variable "exclude_folders" {
  description = "Set of folders to exclude from the policy"
  type        = set(string)
  default     = []
}

variable "exclude_projects" {
  description = "Set of projects to exclude from the policy"
  type        = set(string)
  default     = []
}

variable "allow_list_length" {
  description = "The number of elements in the allow list"
  type        = number
  default     = 0
}

variable "deny_list_length" {
  description = "The number of elements in the deny list"
  type        = number
  default     = 0
}
