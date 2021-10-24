output "gcp_project_id" {
  description = "The ID of the project in which resources are provisioned."
  value       = var.project_id
}
output "resource_name" {
  description = "Name of cloud armor policy created"
  value       = lookup(module.instance.security_policies,keys(module.instance.security_policies)[0]).name
}