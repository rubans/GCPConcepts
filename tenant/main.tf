# Setup base infrastructure required to stand up a tenant
module tenant_base_infra  {
  source = "./shared_service/base_infra"
  domain = var.domain
  region = var.region 
  environment = var.environment
  billing_account = var.billing_account  
  tenant_name = var.tenant_name
}

# Setup shared jenkins deployment running on GKE 
module tenant_gke_shared_service_jenkins {
  source          = "./shared_service/jenkins_gke"
  project         = module.tenant_base_infra.shared_services_project.project.project_id
  region          = var.region
  prefix          = var.prefix
  environment     = var.environment
  tenant_name     = var.tenant_name
  network         = module.tenant_base_infra.tenant_shared_host_network
  subnet          = module.tenant_base_infra.tenant_subnets["${var.region}_gke-shared-service"].subnet
}

# # Setup workload deployment running on GKE
# module tenant_gke_workload {
#   source          = "./workload"
#   project         = module.tenant_base_infra.workload_project.project.project_id
#   region          = var.region
#   prefix          = var.prefix
#   environment     = var.environment
#   tenant_name     = var.tenant_name
#   subnet          = module.tenant_base_infra.tenant_subnets["${var.region}_gke-workload"].subnet
#   service_account_id = "jenkins-sa"
#   applications = {"pathfinder":"pathfinder"}
# }