output "vpc_tenant_shared_vpc_network" {
    value = module.vpc_tenant_shared_vpc.network
}

output "vpc_tenant_subnets" {
    value = module.vpc_tenant_subnets
}