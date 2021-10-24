/*
  DEFAULT
*/
variable "project_id" {
  description = "The project_id used to build subnets"
}

variable "env" {
  type        = string
  description = "Env variable (1 char) used for subnets naming"
}

variable "prefix" {
  type        = string
  description = "Used inside subnets objects for naming"
}

variable "tenant_name" {
  type        = string
  description = "Used for naming"
}

/*
  SUBNET
*/
variable "ip_cidr_range" {
  default     = null
  type        = string
  description = "The range of internal addresses that are owned by this subnetwork."
}

variable "network_id" {
  default     = ""
  description = "The network id for the subnet"
}

variable "region" {
  default     = ""
  description = "The GCP region for this subnetwork."
}

variable "description" {
  type        = string
  default     = ""
  description = "(Optional) An description of this resource."
}

variable "secondary_ip_ranges_array" {
  default     = []
  description = "An array of configurations for secondary IP ranges"
}

variable "private_ip_google_access" {
  default     = false
  description = "When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access."
}

variable "log_config_array" {
  default     = []
  description = "Denotes the logging options for the subnetwork flow logs."
  validation {
    condition     = length(var.log_config_array) <= 1
    error_message = "Condition not met for log_config_array: length(var.log_config_array) <= 1 ."
  }
}