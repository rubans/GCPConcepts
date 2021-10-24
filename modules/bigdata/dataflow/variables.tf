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
  description = "The ID of the project in which the resource will be created. Considered the owner of the resources."
  type        = string
}

variable "env" {
  description = "The environment the resource is in"
  type        = string
}

variable "description" {
  description = "What the resource is for. Backend, frontend, etc"
  type        = string
}

variable "labels" {
  description = "Labels (in addition to the defaults)"
  type        = map(string)
  default     = {}
}

variable "template_gcs_path" {
  type        = string
  description = "The GCS path to the Dataflow job template."
}

variable "temp_gcs_location" {
  type        = string
  description = "A writeable location on GCS for the Dataflow job to dump its temporary data."
}

variable "parameters" {
  type        = map(string)
  description = "Key/Value pairs to be passed to the Dataflow job (as used in the template)."
  default     = {}
}

variable "max_workers" {
  type        = number
  description = " The number of workers permitted to work on the job. More workers may improve processing speed at additional cost."
  default     = 1
}

variable "on_delete" {
  type        = string
  description = "One of drain or cancel. Specifies behavior of deletion during terraform destroy. The default is cancel."
  default     = "cancel"
}

variable "zone" {
  type        = string
  description = "The zone in which the created job should run."
  default     = ""
}

variable "service_account_email" {
  type        = string
  description = "The Service Account email that will be used to identify the VMs in which the jobs are running"
  default     = ""
}

variable "subnetwork_self_link" {
  type        = string
  description = "The subnetwork self link to which VMs will be assigned."
  default     = ""
}

variable "network_self_link" {
  type        = string
  description = "The network self link to which VMs will be assigned."
  default     = "default"
}

variable "machine_type" {
  type        = string
  description = "The machine type to use for the job."
  default     = ""
}

variable "ip_configuration" {
  type        = string
  description = "The configuration for VM IPs. Options are 'WORKER_IP_PUBLIC' or 'WORKER_IP_PRIVATE'."
  default     = null
}

variable "kms_key_name" {
  type        = string
  description = "The name for the Cloud KMS key for the job. Key format is: projects/PROJECT_ID/locations/LOCATION/keyRings/KEY_RING/cryptoKeys/KEY"
  default     = null
}
