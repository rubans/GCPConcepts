output "resource_name" {
  description = "Name of bucket created."
  value       = module.cloud_storage.name
}


output "project_id" {
  description = "The ID of the project in which resources are provisioned."
  value       = var.project_id
}