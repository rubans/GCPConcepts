output "console_link" {
  description = "The console link to the destination storage bucket"
  value       = "https://console.cloud.google.com/cloudpubsub/topics/${module.pubsub.topic}?project=${module.pubsub.project}"
}

output "project" {
  description = "The project in which the topic was created."
  value       = module.pubsub.project
}

output "topic_name" {
  description = "The resource name for the destination topic"
  value       = module.pubsub.topic
}

output "topic_id" {
  description = "The resource id for the destination topic"
  value       = module.pubsub.id
}

output "destination_uri" {
  description = "The destination URI for the topic."
  value       = local.destination_uri
}

output "storage_default_service_account_email" {
  description = "The email address of the default storage service account. Needed for key permissions."
  value       = module.pubsub.storage_default_service_account_email
}
