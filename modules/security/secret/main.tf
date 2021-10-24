resource "google_secret_manager_secret_version" "secret" {
  secret = var.secret_id
  secret_data = var.data
}