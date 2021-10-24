output "resource_name" {
  description = "Name of resource created."
  value       = module.instance.name
}


output "gcp_project_id" {
  description = "The ID of the project in which resources are provisioned."
  value       = var.project_id
}
