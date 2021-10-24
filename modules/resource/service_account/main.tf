resource "google_service_account" "account" {
  account_id   = var.account_id
  display_name = var.display_name
  description  = var.description
  project      = var.project
}

resource "google_service_account_key" "keys" {
  count              = var.keys ? 1 : 0
  service_account_id = google_service_account.account.email
}

module service_account_policy_iam {
  source = "../../iam/resource/service_account"

  account_id = google_service_account.account.name

  iam_method   = var.iam_method
  iam_bindings = var.iam_bindings
}
