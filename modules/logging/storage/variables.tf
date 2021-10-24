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

variable "prefix" {
  description = "The string used to prefix resources within this folder. Considered to be the cost owner of all resources in said folder."
  type        = string
}

variable "project" {
  description = "The ID of the project in which the storage bucket will be created. Considered the owner of the resources."
  type        = string
}

variable "env" {
  description = "The name of the environment the project is in."
  type        = string
}

variable "description" {
  description = "A description of what the resource is for."
  type        = string
  default     = "logging"
}

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
  description = "The name of the encryption key used to encrypt the contents of the bucket."
  type        = string
}

variable "bucket_lock_enabled" {
  description = "Lock the bucket to prevent deletion."
  type        = bool
  default     = false
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

variable "retention_policy_enabled" {
  description = "Enables the bucket retention policy. Off by default"
  type        = bool
  default     = false
}

