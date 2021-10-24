// Mandatory values
variable "name" {
  type        = string
  description = "The name of the project to create"
}

//Note: only folder_id is allowed as a parent. Projects cannot be created directly under the organisation with this module
variable "folder_id" {
  type        = string
  description = "The parent folder for this project"
}

variable "billing_account" {
  type        = string
  description = "The alphanumeric ID of the billing account this project belongs to."
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

variable "audit_configs" {
  description = "A map of audit configurations"
  type        = map(list(string))
  default     = {}
}

variable "labels" {
  type        = map(string)
  description = "A set of key/value label pairs to assign to the project."
  default     = null
}

// Default values that can be overridden
variable "skip_delete" {
  type        = bool
  description = "If true, the Terraform resource can be deleted without deleting the Project via the Google API."
  default     = false
}

variable "auto_create_network" {
  type        = bool
  description = "Create the 'default' network automatically"
  default     = false
}

variable "services" {
  type        = list(string)
  description = "Enable required services on the project"
  default     = []
}

variable "oslogin" {
  description = "Enable oslogin?"
  type        = bool
  default     = true
}

variable "project_type" {
  description = "Set to HOST, SERVICE or SINGLE"
  type        = string
  default     = "SINGLE"
}

variable "host_project_id" {
  description = "Must be set is shared project is set to SERVICE"
  type        = string
  default     = null
}
