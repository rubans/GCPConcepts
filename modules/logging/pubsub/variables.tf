variable "prefix" {
  description = "The string used to prefix resources within this folder. Considered to be the cost owner of all resources in said folder."
  type        = string
}

variable "project" {
  description = "The ID of the project in which the resource will be created. Considered the owner of the resources."
  type        = string
}

variable "env" {
  description = "The environment the resource is in"
  type        = string
}

variable "description" {
  description = "What the resource is for. Backend, frontend, etc"
  type        = string
  default     = "logging"
}

variable "labels" {
  description = "Labels (in addition to the defaults)"
  type        = map(string)
  default     = {}
}

variable "key_name" {
  description = "The name of the encryption key used to encrypt the contents of the bucket"
  type        = string
}

variable "allowed_persistence_regions" {
  description = "Regions in which the pubsub topic may persist data."
  type        = list
}

variable "log_type" {
  description = "The type of logs stored in the bucket, either DEFAULT or AUDIT."
  type        = string
  validation {
    condition = (
      var.log_type == "DEFAULT" ||
      var.log_type == "AUDIT"
    )
    error_message = "The log_type value must be DEFAULT or AUDIT."
  }
}

variable "log_sink_writer_identity" {
  description = "The service account that logging uses to write log entries to the destination. (This is available as an output coming from the root module)."
  type        = string
}
