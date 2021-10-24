/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

###############################################################################
#                                zone variables                               #
###############################################################################
# common
variable "project" {
  description = "The project ID to create the resources in."
  type        = string
}
variable "prefix" {
  description = "Prefix attributed to client"
  type        = string
}
variable "tenant_name" {
  description = "Tenant Name usage for consumption"
  type        = string
}
variable "environment" {
	type = string
	description = "Environment type"
}
#clouddns specific
variable "client_networks" {
  description = "List of VPC self links that can see this zone."
  type        = list(string)
  default     = []
}

variable "default_key_specs_key" {
  description = "DNSSEC default key signing specifications: algorithm, key_length, key_type, kind."
  type        = any
  default     = {}
}

variable "default_key_specs_zone" {
  description = "DNSSEC default zone signing specifications: algorithm, key_length, key_type, kind."
  type        = any
  default     = {}
}

variable "dnssec_config" {
  description = "DNSSEC configuration: kind, non_existence, state."
  type        = any
  default     = {}
}

variable "domain" {
  description = "Zone domain, must end with a period."
  type        = string
}

variable "forwarders" {
  description = "List of target name servers, only valid for 'forwarding' zone types."
  type        = list(string)
  default     = []
}

variable "peer_network" {
  description = "Peering network self link, only valid for 'peering' zone types."
  type        = string
  default     = null
}

variable "recordsets" {
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
  description = "List of DNS record objects to manage."
  default     = []
}

variable "service_directory_namespace" {
  description = "Service directory namespace id (URL), only valid for 'service-directory' zone types."
  type        = string
  default     = null
}

variable "type" {
  description = "Type of zone to create, valid values are 'public', 'private', 'forwarding', 'peering', 'service-directory'."
  type        = string
  default     = "private"
}