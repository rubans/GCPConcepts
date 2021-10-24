variable "project" {
  description = "The name of the project"
}

variable "prefix" {
  description = "Used for naming"
}

variable "tenant_name" {
  description = "Used for naming"
}

variable "env" {
  description = "Environment (d, t, p)"
}

variable "routing_mode" {
  default     = "GLOBAL"
  description = "The network-wide routing mode to use. (REGIONAL||GLOBAL)"
}

variable "description" {
  type        = string
  description = "A description of the vpc"
  default     = null
}

variable "delete_default_routes_on_create" {
  type        = bool
  description = "Default routes (0.0.0.0/0) will be deleted immediately after network creation."
  default     = false
}

variable "shared" {
  description = "Define the vpc as a shared"
  type        = bool
  default     = false
}

variable "mtu" {
  default     = 1460
  description = "Maximum Transmission Unit in bytes. (min. 1460; max 1500 bytes)"
}
