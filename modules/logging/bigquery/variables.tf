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
  description = "The ID of the project in which the bigquery dataset will be created."
  type        = string
}

variable "env" {
  description = "The environment the resource is in"
  type        = string
}

variable "description" {
  description = "A use-friendly description of the dataset"
  type        = string
  default     = "logging"
}

variable "location" {
  description = "The location of the storage bucket."
  type        = string
  default     = "EU"
}

variable "delete_contents_on_destroy" {
  description = "If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present."
  type        = bool
  default     = true
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

variable "kms_key_name" {
  description = "The name of the encryption key used to encrypt the contents of the bucket"
  type = string
}

variable "log_sink_writer_identity" {
  description = "The service account that logging uses to write log entries to the destination. (This is available as an output coming from the root module)."
  type        = string
}

