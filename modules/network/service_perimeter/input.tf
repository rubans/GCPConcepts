variable "org_id" {
  description = "Organization id in nnnnnn format."
  type        = number
}

variable "project_id" {
  description = "Project id in nnnnnn format."
  type        = number
}

variable "perimeter_members" {
  description = "The service accounts and users that belong to the perimeter"
  type        = list
}
