module "vpc" {
  env         = var.env
  prefix      = var.prefix
  tenant_name = var.tenant_name
  source      = "../../../../vpc"
  project = {
    name       = var.project_id
    project_id = var.project_id
  }

  shared = false
}

module "subnet" {
  source      = "../../../../subnet"
  project_id  = var.project_id
  env         = var.env
  prefix      = var.prefix
  tenant_name = var.tenant_name

  ip_cidr_range = "10.0.0.0/23"
  network_id    = module.vpc.network.id
  region        = "europe-west2"
  description   = "desc"

  secondary_ip_ranges_array = [
    {
      ip_cidr_range = "10.0.2.0/23"
      range_name    = "sec"
    },
    {
      ip_cidr_range = "10.0.4.0/23"
      range_name    = "sec2"
    },
  ]

  private_ip_google_access = false

  log_config_array = [
    {
      aggregation_interval = "INTERVAL_1_MIN"
      flow_sampling        = 0.5
      metadata             = "CUSTOM_METADATA"
    }
  ]
}
