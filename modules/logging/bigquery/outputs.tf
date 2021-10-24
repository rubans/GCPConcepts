output "console_link" {
  description = "The console link to the destination bigquery dataset"
  value       = "https://bigquery.cloud.google.com/dataset/${var.project}:${module.bigquery.bigquery_dataset.dataset_id}"
}

output "project" {
  description = "The project in which the bigquery dataset was created."
  value       = module.bigquery.bigquery_dataset.project
}

output "resource_id" {
  description = "The resource id for the destination bigquery dataset"
  value       = module.bigquery.bigquery_dataset.id
}

output "dataset_ide" {
  description = "The dataset id for the destination bigquery dataset"
  value       = module.bigquery.bigquery_dataset.dataset_id
}

output "self_link" {
  description = "The self_link URI for the destination bigquery dataset"
  value       = module.bigquery.bigquery_dataset.self_link
}

output "destination_uri" {
  description = "The destination URI for the bigquery dataset."
  value       = local.destination_uri
}

output "bigquery_default_service_account_email" {
  description = "The email address of the default bigquery service account. Needed for key permissions."
  value       = module.bigquery.bigquery_default_service_account_email
}
