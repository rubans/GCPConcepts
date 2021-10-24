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
  type        = string
  description = "The range of internal addresses that are owned by this subnetwork."
}

variable "network_id" {
  description = "The network id for the subnet"
}

variable "region" {
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
//  validation {
//    condition = resource_name && contains(
//      [
//        "INTERVAL_5_SEC",
//        "INTERVAL_30_SEC",
//        "INTERVAL_1_MIN",
//        "INTERVAL_5_MIN",
//        "INTERVAL_10_MIN",
//        "INTERVAL_15_MIN"
//      ],
//    var.log_config_array[0].aggregation_interval)
//    error_message = "Aggregation_interval must be one of these: \nINTERVAL_5_SEC, INTERVAL_30_SEC, INTERVAL_1_MIN, INTERVAL_5_MIN, INTERVAL_10_MIN, INTERVAL_15_MIN."
//  }
//  validation {
//    condition = contains(
//      [
//        "INCLUDE_ALL_METADATA",
//        "EXCLUDE_ALL_METADATA",
//        "INCLUDE_ALL_METADATA",
//        "CUSTOM_METADATA"
//      ],
//    var.log_config_array[0].metadata)
//    error_message = "Metadata must be one of these: \nINCLUDE_ALL_METADATA, EXCLUDE_ALL_METADATA, INCLUDE_ALL_METADATA, CUSTOM_METADATA."
//  }
}

