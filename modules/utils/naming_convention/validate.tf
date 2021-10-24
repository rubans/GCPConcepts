module "environment" {
  source   = "./environment"
  environment = var.environment
}
module "suffix" {
  source   = "./suffix"
}
module "resource_type" {
  source   = "./resource_type"
  resource_type = var.resource_type
}
module "location" {
  count    = var.location == null ? 0 : 1
  source   = "./location"
  location = var.location
}

module "validate" {
  source            = "./main"
  environment_abbr   = module.environment.abbr
  prefix             = var.prefix
  location_abbr      = var.location == null ? "" : tostring(module.location[0].abbr)
  resource_type_abbr = module.resource_type.abbr
  suffix             = module.suffix.generated
  tenant_name        = var.tenant_name
  job                = var.job
}