resource "random_id" "suffix" {
  byte_length = 2
}

module "location" {
  source   = "../../utils/naming_convention/location"
  location = var.region # Using the region as it is more broad
}

locals {
  location_abbr = module.location.abbr
  resource_abbr = "red" # redis
  # Max length for a redis name is 39 characters
  # So the project is removed, as the longest single string
  name          = lower("${var.prefix}-${var.env}-${var.description}-${local.location_abbr}-${local.resource_abbr}-${random_id.suffix.hex}")
  default_labels = {
    prefix             = var.prefix
    project            = var.project
    env                = var.env
    description        = var.description
    location           = local.location_abbr
  }
  labels = merge(local.default_labels, var.labels)
}

resource "google_redis_instance" "redis" {
  name                     = local.name
  display_name             = local.name
  project                  = var.project
  location_id              = var.location_id
  alternative_location_id  = var.alternative_location_id
  authorized_network       = var.authorized_network
  redis_configs            = var.redis_configs
  memory_size_gb           = var.memory_size_gb
  tier                     = var.tier
  redis_version            = var.redis_version
  connect_mode             = var.connect_mode
  auth_enabled             = var.auth_enabled
  transit_encryption_mode  = var.transit_encryption_mode
  labels                   = local.labels
}
