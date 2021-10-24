output "console_link" {
  description = "The console link to the destination storage bucket"
  value       = "https://console.cloud.google.com/storage/browser/${module.bucket.name}?project=${var.project}"
}

output "resource_name" {
  description = "The resource name for the destination storage bucket"
  value       = module.bucket.name
}

output "destination_uri" {
  description = "The destination URI for the storage bucket."
  value       = local.destination_uri
}

output "storage_default_service_account_email" {
  description = "The email address of the default storage service account. Needed for key permissions."
  value       = module.bucket.storage_default_service_account_email
}
