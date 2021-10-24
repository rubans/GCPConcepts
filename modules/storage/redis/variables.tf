variable "prefix" {
  description = "The string used to prefix resources within this folder. Considered to be the cost owner of all resources in said folder."
  type        = string
}

variable "project" {
  description = "The ID of the project in which the resource will be created. Considered the owner of the resources."
  type        = string
}

variable "env" {
  description = "The environment the resource is in."
  type        = string
}

variable "description" {
  description = "What the resource is for. Backend, frontend, etc."
  type        = string
}

variable "labels" {
  description = "Labels (in addition to the defaults)."
  type        = map(string)
  default     = {}
}

variable "tier" {
  description = "The storage tier of the redis instance." 
  type        = string
  default     = "BASIC"
  validation {
    condition = (
      var.tier == "BASIC" ||
      var.tier == "STANDARD_HA"
    )
    error_message = "The tier value must be BASIC or STANDARD_HA."
  }
}

# Prefer region over locations
variable "region" {
  description = "The region of the redis instance."
  type        = string
}

variable "location_id" {
  description = "The primary location of the redis instance."
  type        = string
  default     = null
}

variable "alternative_location_id" {
  description = "The secondary location of the redis instance. Required for HA."
  type        = string
  default     = null
}

variable "authorized_network" {
  description = "The network that the redis instance should use."
  type        = string
  default     = null
}

variable "redis_configs" {
  description = "Redis configuration parameters."
  type        = map(string)
  default     = null
}

variable "memory_size_gb" {
  description = "The amount of memory the redis instance has, in GiB."
  type        = number
  default     = 1
}

variable "redis_version" {
  description = "The version of redis to use. Null uses the latest."
  type        = string
  default     = null
}

variable "connect_mode" {
  description = "The connection mode of the redis instance."
  type        = string
  default     = "DIRECT_PEERING"
}

variable "transit_encryption_mode" {
  description = "Specifies the encryption mode to use."
  type        = string
  default    = null
}

variable "auth_enabled" {
  description = "Specifies in auth is enabled on the instance."
  type        = bool
  default     = false
}

# Seems to be a provider bug not ignoring this when set to null
#variable "auth_string" {
#  description = "The auth string set on the instance. Requires auth to be enabled."
#  type        = string
#  default     = null
#}
