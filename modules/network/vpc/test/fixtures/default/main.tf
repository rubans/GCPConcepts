module "vpc" {
  source = "../../../../vpc"
  project = {
    project_id = var.project_id
  }
  description = ""
  prefix      = var.prefix
  env         = var.env
  tenant_name = var.tenant_name

  routing_mode                    = "GLOBAL"
  mtu                             = 1460
  delete_default_routes_on_create = false
}
