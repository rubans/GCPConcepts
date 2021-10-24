# create shared VPC (host) network 
module vpc_tenant_shared_vpc {
  source = "../../../../modules//network/vpc"
  project                    = var.host_project
  prefix                     = var.prefix
  tenant_name                = var.tenant_name
  env                        = var.environment
  shared = true
}
# create required subnets
module vpc_tenant_subnets {
  source = "../../../../modules//network/subnet"
  for_each = {
    for i, v in var.service_projects:  "${v.subnet.region}_${v.subnet.job}" => v
    if(lookup(v,"subnet",null) != null)
  }
  
  project_id                 = var.host_project.project_id
  env                        = var.environment
  region                     = each.value.subnet.region
  tenant_name                = var.tenant_name
  network_id                 = module.vpc_tenant_shared_vpc.network.id
  ip_cidr_range              = each.value.subnet.ip_range
  prefix                     = var.prefix
  secondary_ip_ranges_array  = each.value.subnet.secondary_ip_range
  private_ip_google_access   = true
}
# attach each service project(s) to host shared vpc
resource "google_compute_shared_vpc_service_project" "shared" {
  for_each = {for i, v in var.service_projects:  i => v}
  depends_on = [module.vpc_tenant_shared_vpc]
  host_project    = var.host_project.project_id
  service_project = each.value.project.project_id
}
