locals {
  shielded_vm_configs = var.enable_shielded_vm ? [true] : []
}

resource "google_compute_instance" "vm_instance" {
  project      = var.project
  name         = var.name
  zone         = var.zone
  machine_type = var.machine_type
  allow_stopping_for_update = var.allow_stopping_for_update

  # dynamic "service_account" {
  #   for_each = [var.service_account]
  #   content {
  #     email  = lookup(service_account.value, "email", null)
  #     scopes = lookup(service_account.value, "scopes", null)
  #   }
  # }

  boot_disk {
    # kms_key_self_link = var.kms_key_self_link
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name
    subnetwork_project = var.project
  }

  dynamic "shielded_instance_config" {
    for_each = local.shielded_vm_configs
    content {
      enable_secure_boot          = true
      enable_vtpm                 = true
      enable_integrity_monitoring = true
    }
  }

  metadata = merge(var.metadata, var.extra_metadata)
}