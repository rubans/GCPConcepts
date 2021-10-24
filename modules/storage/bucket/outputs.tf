/**
 * Copyright 2018 Google LLC
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

output "bucket" {
  description = "Bucket resource"
  value       = google_storage_bucket.bucket
}

output "name" {
  description = "Bucket name"
  value       = google_storage_bucket.bucket.name
}

output "url" {
  description = "Bucket URL"
  value       = google_storage_bucket.bucket.url
}

output "console_link" {
  description = "The console link to the destination storage bucket"
  value       = "https://console.cloud.google.com/storage/browser/${google_storage_bucket.bucket.name}?project=${var.project}"
}

output "storage_default_service_account_email" {
  value       = data.google_storage_project_service_account.storage_sa.email_address
  description = "The email address of the default storage service account. Needed for key permissions."
}

