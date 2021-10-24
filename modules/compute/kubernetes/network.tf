module "validate_network_resource_type" {
  source = "../../utils/naming_convention/resource_type"
  resource_type = "google_compute_network"
}

locals {
  new_network_name = format(local.resource_name_template,"",module.validate_network_resource_type.abbr,local.job_tag)
  new_subnetwork_name = format(local.resource_name_template,local.location_tag,module.validate_network_resource_type.abbr,local.job_tag)
}

resource "google_compute_network" "main" {
  count           = var.create_default_network ? 1 : 0
  project         = var.project
  name            = local.new_network_name
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "main" {
  count         = var.create_default_network ? 1 : 0
  project       = var.project
  region        = var.region
  name          = local.new_subnetwork_name
  ip_cidr_range = "10.128.0.0/20"
  # purpose       = "INTERNAL_HTTPS_LOAD_BALANCER"
  # role          = "ACTIVE"
  secondary_ip_range = [{
      range_name    = "gkepods"
      ip_cidr_range = "192.168.0.0/18"
    },
    {
        range_name    = "gkeservices"
        ip_cidr_range = "192.168.64.0/18"
    }]
  network       = google_compute_network.main[count.index].self_link
}