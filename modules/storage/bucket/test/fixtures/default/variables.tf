variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "location" {
  description = "The zone in which to provision resources."
  type        = string
}

variable "storage_class" {
  description = "The storage_class of the bucket."
  type        = string
}