resource "random_string" "prefix" {
  length  = 10
  upper   = false
  special = false
}
locals {
     name = "kitchen-test-${random_string.prefix.result}"
}


module "instance" {
  source          = "../../.."
  project      = var.project_id
  zone          = var.zone
  name = local.name
  image = var.image
  machine_type = var.machine_type
  service_account = var.service_account
  kms_key_self_link = var.kms_key_self_link
  network_name      = google_compute_network.main.self_link
  subnetwork_name      = google_compute_subnetwork.main.self_link
}




