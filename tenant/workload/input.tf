variable "project" {
  type        = string
  description = "Project to deploy this pattern into"
}
variable "region" {
  type        = string
  description = "Region to deploy this pattern into"
}
variable "service_account_id" {
  type        = string
  description = "Service account"
  default     = "jenkins-sa"
}
variable "prefix" {
  description = "Prefix attributed to client"
  type        = string
}
variable "tenant_name" {
  description = "Tenant Name usage for consumption"
  type        = string
}
variable "environment" {
	type = string
	description = "Environment type"
}
variable "applications" {
  type        = map(string)
  description = "Applications and namespace"
  default     = {"pathfinder":"pathfinder"}
}
variable "subnet" {
  description = "subnet of the GKE resource"
}