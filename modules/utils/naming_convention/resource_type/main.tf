variable "resource_type" {
  description = "The resource type"
  type        = string
  validation {
    condition = (
      contains(["google_compute_security_policy", 
                "google_compute_instance",
                "google_container_cluster",
                "google_compute_firewall",
                "google_dns",
                "google_compute_network",
                "google_compute_subnetwork",
                "google_storage_bucket"], 
        var.resource_type) == true
      )
      error_message = "The resource_type must match one of the allowed values."
  }
}

locals {
  resource_type_map = {
    "google_compute_security_policy" = "csp",
    "google_compute_instance"        = "cin",
    "google_dns"                     = "dns",
    "google_compute_firewall"        = "gcf",
    "google_container_cluster"       = "gke"
    "google_compute_network"         = "vpc",
    "google_compute_subnetwork"      = "sub",
    "google_storage_bucket"          = "gcs"
  }
  resource_type_abbr  = local.resource_type_map[var.resource_type]
}
