resource "google_endpoints_service" "openapi_service" {
  service_name   = "${var.name}.endpoints.${var.project_id}.cloud.goog"
  project        = var.project_id
  openapi_config = file(var.specification)
}
