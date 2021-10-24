output "resource_name" {
  description = "Name of subnet created."
  value       = module.subnet.subnet.name
}

output "gcp_project_id" {
  description = "The ID of the project in which resources are provisioned."
  value       = var.project_id
}

output "region" {
  description = "Region where the resource is deployed."
  value       = module.subnet.subnet.region
}
