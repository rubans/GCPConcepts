output "environment_abbr" {
  description = "The abbreviation of the environment"
  value       = module.environment.abbr
}
output "resource_type_abbr" {
  description = "The abbreviation of the environment"
  value       = module.resource_type.abbr
}
output "suffix" {
  description = "Suffix generated"
  value       = module.suffix.generated
}
output "location_abbr" {
  description = "The abbreviation of the location"
  value       = var.location == null ? "" : tostring(module.location[0].abbr)
}