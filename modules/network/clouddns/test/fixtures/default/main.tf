resource "random_string" "string" {
  length  = 4
  special = false
}

module "instance" {
  source            = "../../.."
  project           = var.project_id
  environment       = "dev"
  prefix            = "cap"
  tenant_name       = "kitchen"
  type              = "public"
  domain            = "kitchen-test${random_string.string.id}.example."
  recordsets = [
    { name = "localhost", type = "A", ttl = 300, records = ["127.0.0.1"] }
  ]
}




