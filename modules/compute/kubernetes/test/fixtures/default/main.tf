resource "random_string" "prefix" {
  length  = 10
  upper   = false
  special = false
}

module "instance" {
  # create a private cluster with externally accessible public endpoint accessible
  # with any required dependencies default network vpc/subnet
  source          = "../../.."
  project         = var.project_id
  environment     = "dev"
  prefix          = "cap"
  tenant_name     = "kitchen"
  region          = var.region
  zone            = var.zone
  create_default_network = true
  private_cluster = true
  private_endpoint  = false
}




