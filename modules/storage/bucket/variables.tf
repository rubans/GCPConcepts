/**
 * Copyright 2018 Google LLC
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
# common
variable "prefix" {
  description = "The string used to prefix resources within this folder. Considered to be the cost owner of all resources in said folder."
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

variable "job" {
  description = "Resource role functional job description"
  type        = string
  default     = ""
}
variable "region" {
  type        = string
  description = "Region to deploy this pattern into"
  default     = null
}

variable "project" {
  description = "The ID of the project in which the storage bucket will be created. Considered the owner of the resources."
  type        = string
}

variable "description" {
  description = "What the resource is for. Backend, frontend, etc"
  type        = string
}
# GCS
variable "location" {
  description = "The location of the storage bucket."
  type        = string
  default     = "EU"
}

variable "storage_class" {
  description = "The storage class of the storage bucket."
  type        = string
  default     = "STANDARD"
}

variable "force_destroy" {
  description = "Destroy the contents of the bucket when the bucket is deleted."
  type        = bool
  default     = true
}

variable "key_name" {
  description = "The name of the encryption key used to encrypt the contents of the bucket"
  type        = string
  default     = null
}

variable "data_classification" {
  description = "The type of data stored in the bucket, either PUBLIC, DEFAULT or AUDIT."
  type        = string
  validation {
    condition = (
      var.data_classification == "PUBLIC" ||
      var.data_classification == "DEFAULT" ||
      var.data_classification == "AUDIT"
    )
    error_message = "The data_classification value must be PUBLIC, DEFAULT or AUDIT."
  }
  default    = "DEFAULT"
}

variable "versioning_enabled" {
  description = "Enables versioning of objects within the bucket. Off by default"
  type        = bool
  default     = false
}

variable "retention_policy_enabled" {
  description = "Enables the bucket retention policy. Off by default"
  type        = bool
  default     = false
}

variable "lifecycle_rules" {
  type = list(object({
    # Object with keys:
    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.
    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.
    action = map(string)

    # Object with keys:
    # - age - (Optional) Minimum age of an object in days to satisfy this condition.
    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.
    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".
    # - matches_storage_class - (Optional) Comma delimited string for storage class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.
    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.
    condition = map(string)
  }))
  description = "List of lifecycle rules to configure. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule except condition.matches_storage_class should be a comma delimited string."
  default     = null
}

variable "cors" {
  description = "Map of maps of mixed type attributes for CORS values. See appropriate attribute types here: https://www.terraform.io/docs/providers/google/r/storage_bucket.html#cors"
  type        = any
  default     = null
}

variable "website" {
  description = "Map of website values. Supported attributes: main_page_suffix, not_found_page"
  type        = any
  default     = null
}

variable "bucket_logging" {
  description = "Enables logging for the GCS bucket"
  type = object({
    log_bucket = string
  })
  default = null
}

variable "bucket_admins" {
  description = "List of bucket admins"
  type        = list
  default     = []
}

variable "bucket_creators" {
  description = "List of bucket creators"
  type        = list
  default     = []
}

variable "bucket_viewers" {
  description = "List of bucket viewers"
  type        = list
  default     = []
}

variable "labels" {
  description = "Labels (in addition to the defaults)"
  type        = map(string)
  default     = {}
}

variable "iam_method" {
  type        = string
  description = "IAM Binding method MEMBER|BINDING|POLICY"
  default     = "MEMBER"
}

variable "iam_bindings" {
  description = "Map of members with a list of roles for each member"
  type        = map(list(string))
  default     = {}
}
