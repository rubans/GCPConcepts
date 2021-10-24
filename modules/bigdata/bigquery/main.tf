resource "random_id" "suffix" {
  byte_length = 2
}

module "location" {
  source   = "../../utils/naming_convention/location"
  location = var.location
}

locals {
  location_abbr = module.location.abbr
  resource_abbr = "sct"
  dataset_id    = replace(lower("${var.prefix}-${var.project}-${var.env}-${var.description}-${local.location_abbr}-${local.resource_abbr}-${random_id.suffix.hex}"), "-", "_")
  tables        = { for table in var.tables : table["table_id"] => table }
  views         = { for view in var.views : view["view_id"] => view }
  data_classifications = {
    "PUBLIC"  = "public"
    "DEFAULT" = "confidential",
    "AUDIT"   = "highlyconfidential"
  }
  iam_to_primitive = {
    "roles/bigquery.dataOwner" : "OWNER"
    "roles/bigquery.dataEditor" : "WRITER"
    "roles/bigquery.dataViewer" : "READER"
  }
  default_labels = {
    prefix             = var.prefix
    project            = var.project
    env                = var.env
    description        = var.description
    location           = local.location_abbr
    dataclassification = lookup(local.data_classifications, var.data_classification, "confidential")
  }
  labels = merge(local.default_labels, var.labels)
}

// Default service account is set up to prepare for encryption
data "google_bigquery_default_service_account" "bq_sa" {
  project = var.project
}

resource "google_bigquery_dataset" "main" {
  dataset_id                  = local.dataset_id
  friendly_name               = local.dataset_id
  description                 = var.description
  location                    = var.location
  delete_contents_on_destroy  = var.delete_contents_on_destroy
  project                     = var.project
  labels                      = local.labels
  default_table_expiration_ms = lookup(var.default_expiration_period_ms, var.data_classification, 2592000000) # default 30 days

  dynamic "access" {
    for_each = var.access
    content {
      # BigQuery API converts IAM to primitive roles in its backend.
      # This causes Terraform to show a diff on every plan that uses IAM equivalent roles.
      # Thus, do the conversion between IAM to primitive role here to prevent the diff.
      role = lookup(local.iam_to_primitive, access.value.role, access.value.role)

      domain         = lookup(access.value, "domain", null)
      group_by_email = lookup(access.value, "group_by_email", null)
      user_by_email  = lookup(access.value, "user_by_email", null)
      special_group  = lookup(access.value, "special_group", null)
    }
  }

  dynamic "default_encryption_configuration" {
    for_each = var.kms_key_name == null ? [] : [var.kms_key_name]
    content {
      kms_key_name = var.kms_key_name
    }
  }
}

resource "google_bigquery_table" "main" {
  for_each        = local.tables
  dataset_id      = google_bigquery_dataset.main.dataset_id
  friendly_name   = each.key
  table_id        = each.key
  labels          = each.value["labels"]
  schema          = file(each.value["schema"])
  clustering      = each.value["clustering"]
  expiration_time = each.value["expiration_time"]
  project         = var.project

  dynamic "encryption_configuration" {
    for_each = var.kms_key_name == null ? [] : [var.kms_key_name]
    content {
      kms_key_name = var.kms_key_name
    }
  }

  dynamic "time_partitioning" {
    for_each = each.value["time_partitioning"] != null ? [each.value["time_partitioning"]] : []
    content {
      type                     = time_partitioning.value["type"]
      expiration_ms            = time_partitioning.value["expiration_ms"]
      field                    = time_partitioning.value["field"]
      require_partition_filter = time_partitioning.value["require_partition_filter"]
    }
  }
}

resource "google_bigquery_table" "view" {
  for_each      = local.views
  dataset_id    = google_bigquery_dataset.main.dataset_id
  friendly_name = each.key
  table_id      = each.key
  labels        = each.value["labels"]
  project       = var.project

  view {
    query          = each.value["query"]
    use_legacy_sql = each.value["use_legacy_sql"]
  }
}
