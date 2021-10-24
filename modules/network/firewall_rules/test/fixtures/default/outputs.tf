output "gcp_project_id" {
  description = "The ID of the project in which resources are provisioned."
  value       = var.project_id
}

output "default_deny_ingress" {
  description = "The default deny ingress rule."
  value = module.firewall.deny_ingress_name["default"]
}

output "test1_allow_ingress" {
  description = "The first test ingress rule."
  value = module.firewall.allow_ingress_name["test1"]
}
