output "resource_name" {
  description = "Name of cluster created."
  value       = module.instance.kubernetes_cluster_name
}

output "gcp_project_id" {
  description = "The ID of the project in which resources are provisioned."
  value       = var.project_id
}

output "resource_location" {
  description = "The location of the resource created."
  value       = var.zone
}