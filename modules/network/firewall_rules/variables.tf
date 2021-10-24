# Common

variable "prefix" {
  description = "The string used to prefix resources within this folder. Considered to be the cost owner of all resources in said folder."
  type        = string
}

variable "project" {
  description = "The ID of the project in which the storage bucket will be created. Considered the owner of the resources."
  type        = string
}

variable "env" {
  description = "The environment the module is in"
  type        = string
}

variable "tenant_name" {
  description = "The name of the tenant that owns the resource"
  type        = string
}

variable "network" {
  description = "The network for the firewall rules"
}

variable "log_metadata_config" {
  description = "Enable or disable metadata logging."
  type        = string
  default     = "EXCLUDE_ALL_METADATA"
  validation {
    condition = (
      contains(["EXCLUDE_ALL_METADATA", "INCLUDE_ALL_METADATA"], var.log_metadata_config) == true
    )
    error_message = "The log metadata config must match one of the above values."
  }
}


# TODO: update these to use optional() when that is no longer experimental
variable "allow_ingress" {
  description = "List of rules to allow ingress"
  type = map(object({
    description             = string
    source_ranges           = list(string)
    source_tags             = list(string)
    source_service_accounts = list(string)
    destination_ranges      = list(string)
    target_tags             = list(string)
    target_service_accounts = list(string)
    disabled                = bool
    priority                = number
    protocol                = string
    ports                   = list(string)
  }))
  validation {
    condition = alltrue(
      [for rule in var.allow_ingress :
        ((rule["source_service_accounts"] != null && rule["source_tags"] == null && rule["target_tags"] == null) ||
        rule["source_service_accounts"] == null) &&
        ((rule["target_service_accounts"] != null && rule["source_tags"] == null && rule["target_tags"] == null) ||
        rule["target_service_accounts"] == null)
      ]
    )
    error_message = "Source and target service accounts cannot be used with source and/or target tags."
  }
  default = {}
}


variable "deny_ingress" {
  description = "List of rules to deny ingress"
  type = map(object({
    description             = string
    source_ranges           = list(string)
    source_tags             = list(string)
    source_service_accounts = list(string)
    destination_ranges      = list(string)
    target_tags             = list(string)
    target_service_accounts = list(string)
    disabled                = bool
    priority                = number
    protocol                = string
    ports                   = list(string)
  }))
  validation {
    condition = alltrue(
      [for rule in var.deny_ingress :
        ((rule["source_service_accounts"] != null && rule["source_tags"] == null && rule["target_tags"] == null) ||
        rule["source_service_accounts"] == null) &&
        ((rule["target_service_accounts"] != null && rule["source_tags"] == null && rule["target_tags"] == null) ||
        rule["target_service_accounts"] == null)
      ]
    )
    error_message = "Source and target service accounts cannot be used with source and/or target tags."
  }
  default = {}
}

variable "allow_egress" {
  description = "List of rules to allow egress"
  type = map(object({
    description             = string
    source_ranges           = list(string)
    source_tags             = list(string)
    source_service_accounts = list(string)
    destination_ranges      = list(string)
    target_tags             = list(string)
    target_service_accounts = list(string)
    disabled                = bool
    priority                = number
    protocol                = string
    ports                   = list(string)
  }))
  validation {
    condition = alltrue(
      [for rule in var.allow_egress :
        ((rule["source_service_accounts"] != null && rule["source_tags"] == null && rule["target_tags"] == null) ||
        rule["source_service_accounts"] == null) &&
        ((rule["target_service_accounts"] != null && rule["source_tags"] == null && rule["target_tags"] == null) ||
        rule["target_service_accounts"] == null)
      ]
    )
    error_message = "Source and target service accounts cannot be used with source and/or target tags."
  }
  default = {}
}


variable "deny_egress" {
  description = "List of rules to deny egress"
  type = map(object({
    description             = string
    source_ranges           = list(string)
    source_tags             = list(string)
    source_service_accounts = list(string)
    destination_ranges      = list(string)
    target_tags             = list(string)
    target_service_accounts = list(string)
    disabled                = bool
    priority                = number
    protocol                = string
    ports                   = list(string)
  }))
  validation {
    condition = alltrue(
      [for rule in var.deny_egress :
        ((rule["source_service_accounts"] != null && rule["source_tags"] == null && rule["target_tags"] == null) ||
        rule["source_service_accounts"] == null) &&
        ((rule["target_service_accounts"] != null && rule["source_tags"] == null && rule["target_tags"] == null) ||
        rule["target_service_accounts"] == null)
      ]
    )
    error_message = "Source and target service accounts cannot be used with source and/or target tags."
  }
  default = {}
}
