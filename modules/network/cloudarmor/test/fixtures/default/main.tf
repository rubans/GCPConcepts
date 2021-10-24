module "instance" {
  source          = "../../.."
  project         = var.project_id
  environment     = "dev"
  prefix          = "cap"
  tenant_name        = "kitchen"
  security_policy = var.security_policy
}




