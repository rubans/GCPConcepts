output "shared_services_project" {
  value = module.project_tenant_shared_services
}

output "workload_project" {
  value = module.project_tenant_workloads
}

output "tenant_shared_host_network" {
    value = module.setup_shared_vpc.vpc_tenant_shared_vpc_network
}

output "tenant_subnets" {
    value = module.setup_shared_vpc.vpc_tenant_subnets
}