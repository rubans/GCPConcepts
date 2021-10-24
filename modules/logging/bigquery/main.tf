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

#-----------------#
# Local variables #
#-----------------#

locals {
  destination_uri = "bigquery.googleapis.com/projects/${var.project}/datasets/${module.bigquery.bigquery_dataset.dataset_id}"
}

#------------------#
# Bigquery dataset #
#------------------#

module "bigquery" {
  source = "../../bigdata/bigquery"

  prefix                     = var.prefix
  project                    = var.project
  env                        = var.env
  description                = var.description
  location                   = var.location
  delete_contents_on_destroy = var.delete_contents_on_destroy
  data_classification        = var.log_type
  kms_key_name               = var.kms_key_name
}

#--------------------------------#
# Service account IAM membership #
#--------------------------------#
resource "google_project_iam_member" "bigquery_sink_member" {
  project = module.bigquery.bigquery_dataset.project
  role    = "roles/bigquery.dataEditor"
  member  = var.log_sink_writer_identity
}
