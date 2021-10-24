/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "project" {
  description = "The project in which the topic was created."
  value       = google_pubsub_topic.topic.project
}

output "topic" {
  value       = google_pubsub_topic.topic.name
  description = "The name of the Pub/Sub topic"
}

output "topic_labels" {
  value       = google_pubsub_topic.topic.labels
  description = "Labels assigned to the Pub/Sub topic"
}

output "id" {
  value       = google_pubsub_topic.topic.id
  description = "The ID of the Pub/Sub topic"
}

output "uri" {
  value       = "pubsub.googleapis.com/${google_pubsub_topic.topic.id}"
  description = "The URI of the Pub/Sub topic"
}

output "storage_default_service_account_email" {
  value       = data.google_storage_project_service_account.storage_sa.email_address
  description = "The email address of the default storage service account. Needed for key permissions."
}
