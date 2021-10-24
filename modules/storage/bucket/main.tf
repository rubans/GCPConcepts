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

# common naming convention based resource name related dependencies
module "validate_naming_conventions" {
  source                = "../../utils/naming_convention"
  prefix                = var.prefix         
  environment           = var.environment
  resource_type         = "google_storage_bucket"
  tenant_name           = var.tenant_name
  location              = var.region
}
# storage bucket
locals {
  environment_abbr          = module.validate_naming_conventions.environment_abbr
  suffix                    = module.validate_naming_conventions.suffix
  location_abbr             = module.validate_naming_conventions.location_abbr
  resource_type_abbr        = module.validate_naming_conventions.resource_type_abbr
  job_tag                   = "${var.job != "" ? concat("-",var.job) : ""}"
  location_tag              = "${local.location_abbr != "" ? "-${local.location_abbr}" : ""}"
  resource_name_template    = "${var.prefix}-${var.tenant_name}-${local.environment_abbr}-%s%s%s-${local.suffix}"
  bucket_name               = format(local.resource_name_template,local.resource_type_abbr,local.location_tag,local.job_tag)
  retention_periods = {
    "PUBLIC"  = 1
    "DEFAULT" = 2592000, # 30 days in seconds
    "AUDIT"   = 34560000 # 400 days in seconds
  }
  data_classifications = {
    "PUBLIC"  = "public"
    "DEFAULT" = "confidential",
    "AUDIT"   = "highlyconfidential"
  }
  default_labels = {
    prefix             = var.prefix
    project            = var.project
    env                = var.environment
    description        = var.description
    location           = local.location_abbr
    dataclassification = lookup(local.data_classifications, var.data_classification, "confidential")
  }
  labels = merge(local.default_labels, var.labels)
}

// Storage default service account needed for bucket encryption
data "google_storage_project_service_account" "storage_sa" {
  project = var.project
}

resource "google_storage_bucket" "bucket" {
  name                        = local.bucket_name
  project                     = var.project
  storage_class               = var.storage_class
  location                    = var.location
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = true
  labels                      = local.labels

  versioning {
    enabled = var.versioning_enabled
  }
  
  // Encrypt all data with the key given
  dynamic "encryption" {
    for_each = var.key_name == null ? [] : [var.key_name]
    content {
      default_kms_key_name = var.key_name
    }
  }

  // Store data for a default of 30 days if default class, 1 second if public, or 400 days if audit class
  dynamic "retention_policy" {
    for_each = var.retention_policy_enabled == false ? [] : [var.retention_policy_enabled]
    content {
      is_locked        = true
      retention_period = lookup(local.retention_periods, var.data_classification, 2592000) # default to 30 days
    }
  }

  // Set the cors values if the cors object isn't empty
  dynamic "cors" {
    for_each = var.cors == null ? [] : [var.cors]
    content {
      origin          = lookup(cors.value, "origin", null)
      method          = lookup(cors.value, "method", null)
      response_header = lookup(cors.value, "response_header", null)
      max_age_seconds = lookup(cors.value, "max_age_seconds", null)
    }
  }

  // Set the website values if the website object isn't empty
  dynamic "website" {
    for_each = var.website == null ? [] : [var.website]
    content {
      main_page_suffix = lookup(website.value, "main_page_suffix", null)
      not_found_page   = lookup(website.value, "not_found_page", null)
    }
  }

  // Set the lifecycle rules if the object isn't empty
  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules == null ? [] : var.lifecycle_rules
    content {
      action {
        type          = lookup(lifecycle_rule.value.action, "type", null)
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                   = lookup(lifecycle_rule.value.condition, "age", null)
        created_before        = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state            = lookup(lifecycle_rule.value.condition, "with_state", null)
        matches_storage_class = contains(keys(lifecycle_rule.value.condition), "matches_storage_class") ? split(",", lifecycle_rule.value.condition["matches_storage_class"]) : null
        num_newer_versions    = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
      }
    }
  }

  // Set to log to a bucket logging bucket
  dynamic "logging" {
    for_each = var.bucket_logging == null ? [] : [var.bucket_logging]
    content {
      log_bucket = var.bucket_logging.log_bucket
    }
  }

}

resource "google_storage_bucket_iam_binding" "admins" {
  count   = var.bucket_admins == null ? 0 : 1
  bucket  = google_storage_bucket.bucket.name
  role    = "roles/storage.objectAdmin"
  members = var.bucket_admins
}

resource "google_storage_bucket_iam_binding" "creators" {
  count   = var.bucket_creators == null ? 0 : 1
  bucket  = google_storage_bucket.bucket.name
  role    = "roles/storage.objectCreator"
  members = var.bucket_creators
}

resource "google_storage_bucket_iam_binding" "viewers" {
  count   = var.bucket_viewers == null ? 0 : 1
  bucket  = google_storage_bucket.bucket.name
  role    = "roles/storage.objectViewer"
  members = var.bucket_viewers
}

