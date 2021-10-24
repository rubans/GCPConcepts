resource "random_id" "suffix" {
  byte_length = 2
}

locals {
  resource_abbr = "sct"
  resource_name = lower("${var.prefix}-${var.project}-${var.env}-${var.description}-${local.resource_abbr}-${random_id.suffix.hex}")
  default_labels = {
    prefix             = var.prefix
    project            = var.project
    env                = var.env
    description        = var.description
  }
  labels = merge(local.default_labels, var.labels)
}

resource "google_secret_manager_secret" "secret-basic" {
  secret_id  = local.resource_name
  project    = var.project

  replication {
    automatic = true
  }

  labels = local.labels
}
