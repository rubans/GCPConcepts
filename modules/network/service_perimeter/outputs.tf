output "perimeter_id" {
  description = "VPC-SC standard perimeter resources."

  value = google_access_context_manager_service_perimeter.perimeter.id
}

