output "gcp_project_id" {
  description = "The ID of the project in which resources are provisioned."
  value       = var.project_id
}
output "resource_name" {
  description = "Name of zns created"
  value       = module.instance.name
}