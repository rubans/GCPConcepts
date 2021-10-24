resource "random_id" "suffix" {
  byte_length = 2
}

module "location" {
  source   = "../../utils/naming_convention/location"
  location = var.location
}

locals {
  location_abbr  = module.location.abbr
  keyring_name   = "${var.prefix}-${var.project}-${var.env}-${var.description}-${local.location_abbr}-krg-${random_id.suffix.hex}"
  key_name       = "${var.prefix}-${var.project}-${var.env}-${var.description}-key-${random_id.suffix.hex}"
  default_labels = {
    prefix      = var.prefix
    project     = var.project
    env         = var.env
    description = var.description
    location    = local.location_abbr
  }
  key_labels     = merge(local.default_labels, var.labels)
}


resource "google_kms_key_ring" "keyring" {
  project  = var.project
  name     = local.keyring_name
  location = var.location
}

resource "google_kms_crypto_key" "key" {
  name            = local.key_name
  key_ring        = google_kms_key_ring.keyring.id
  rotation_period = var.rotation_period
  purpose         = var.purpose
  labels          = local.key_labels

  version_template {
    algorithm        = var.algorithm
    protection_level = var.protection_level
  }

// This would normally be enforced, but it is disabled for testing
// It cannot be made optional
//  lifecycle {
//    prevent_destroy = var.prevent_destroy
//  }
}
