module "validate_naming_conventions" {
  source        = "../../utils/naming_convention"
  prefix        = var.prefix
  environment   = var.env
  resource_type = "google_compute_subnetwork"
  tenant_name   = var.tenant_name
}

module "subnets_location_map" {
  source   = "../../utils/naming_convention/location"
  location = var.region
}

locals {
  environment_abbr   = module.validate_naming_conventions.environment_abbr
  location_tag       = module.validate_naming_conventions.location_abbr
  resource_type_abbr = module.validate_naming_conventions.resource_type_abbr
  suffix             = module.validate_naming_conventions.suffix
}

resource "google_compute_subnetwork" "subnet" {
  project = var.project_id
  name    = "${var.prefix}-${var.tenant_name}-${local.environment_abbr}-${local.resource_type_abbr}-${module.subnets_location_map.abbr}-${local.suffix}"

  ip_cidr_range = var.ip_cidr_range
  network       = var.network_id
  region        = var.region
  description   = var.description

  dynamic "secondary_ip_range" {
    for_each = var.secondary_ip_ranges_array
    content {
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
      range_name    = secondary_ip_range.value.range_name
    }
  }

  private_ip_google_access = var.private_ip_google_access

  dynamic "log_config" {
    for_each = var.log_config_array
    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
    }
  }
}
