module "validate_naming_conventions" {
  source        = "../../utils/naming_convention"
  prefix        = var.prefix
  environment   = var.env
  resource_type = "google_compute_network"
  tenant_name   = var.tenant_name
}

locals {
  location_tag       = "g"
  resource_type_abbr = module.validate_naming_conventions.resource_type_abbr
  suffix             = module.validate_naming_conventions.suffix
}

resource "google_compute_network" "vpc" {
  name                            = "${var.prefix}-${var.tenant_name}-${var.env}-${local.resource_type_abbr}-${local.location_tag}-${local.suffix}"
  auto_create_subnetworks         = false
  routing_mode                    = var.routing_mode
  project                         = var.project.project_id
  description                     = var.description
  delete_default_routes_on_create = var.delete_default_routes_on_create
}

resource "google_compute_shared_vpc_host_project" "host" {
  count      = var.shared ? 1 : 0
  project    = var.project.project_id
  depends_on = [google_compute_network.vpc]
}