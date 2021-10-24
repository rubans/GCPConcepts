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

locals {
  destination_uri = "storage.googleapis.com/${module.bucket.name}"
  data_classifications = {
    "DEFAULT" = "confidential",
    "AUDIT"   = "highlyconfidential"
  }
  retention_periods = {
    "DEFAULT" = 30,
    "AUDIT"   = 400
  }
}

#----------------#
# Storage bucket #
#----------------#
module "bucket" {
  source = "../../storage/bucket"

  prefix                   = var.prefix
  project                  = var.project
  env                      = var.env
  description              = var.description
  location                 = var.location
  force_destroy            = var.force_destroy
  key_name                 = var.key_name
  data_classification      = var.log_type
  retention_policy_enabled = var.retention_policy_enabled

  bucket_creators = [var.log_sink_writer_identity]

  // Remove logs that are 1 day older than their retention period
  lifecycle_rules = [
    {
      action = {
        type = "Delete"
      },
      condition = {
        age = lookup(local.retention_periods, var.log_type, 30) + 1
      }
    }
  ]
}

#--------------------------------#
# Service account IAM membership #
#--------------------------------#
//resource "google_storage_bucket_iam_member" "storage_sink_member" {
//  bucket = module.bucket.name
//  role   = "roles/storage.objectCreator"
//  member = var.log_sink_writer_identity
//}

