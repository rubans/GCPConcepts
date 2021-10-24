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
variable "job" {
  description = "Resource role functional job description"
  type        = string
  default     = ""
}
# cloudarmour specific
variable "security_policy" {
  description = "Security policy configuration"
  type        = map
}