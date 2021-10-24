# No type specifications here because we want the modules to restrict this

variable "project_id" {
  description = "The ID of the project in which the storage bucket will be created. Considered the owner of the resources."
}

variable "prefix" {
  description = "The string used to prefix resources within this folder. Considered to be the cost owner of all resources in said folder."
  default     = "kit"
}

variable "env" {
  description = "The environment the module is in"
  default     = "dev"
}

variable "tenant_name" {
  description = "The name of the tenant that owns the resource"
  default     = "test"
}

variable "log_metadata_config" {
  description = "Enable or disable metadata logging."
  default     = "INCLUDE_ALL_METADATA"
}

variable "allow_ingress" {
  description = "List of rules to allow ingress"
  default = {
    test1 = {
      description             = "test 1"
      source_ranges           = ["10.128.0.1/32", "10.128.0.2/32"]
      source_tags             = null
      source_service_accounts = null
      destination_ranges      = null
      target_tags             = null
      target_service_accounts = null
      priority                = 1001
      disabled                = false
      protocol                = "tcp"
      ports                   = ["80"]
    }
  }
}

variable "deny_ingress" {
  description = "List of rules to deny ingress"
  default     = {}
}

variable "allow_egress" {
  description = "List of rules to allow egress"
  default     = {}
}

variable "deny_egress" {
  description = "List of rules to deny egress"
  default     = {}
}

variable "region" {
  description = "Region for the network created."
  default     = "europe-west2"
}
