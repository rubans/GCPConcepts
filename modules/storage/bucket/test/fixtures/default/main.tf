
resource "random_string" "prefix" {
  length  = 10
  upper   = false
  special = false
}

module "cloud_storage" {
  source        = "../../.."
  project       = var.project_id
  description   = "test-bucket"
  location      = var.location
  prefix        = "cap"
  environment   = "test"
  tenant_name   = "kitchen"
  storage_class = var.storage_class
}