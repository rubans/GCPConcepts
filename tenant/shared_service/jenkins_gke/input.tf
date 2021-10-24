variable "project" {
  type        = string
  description = "Project to deploy this pattern into"
}
variable "region" {
  type        = string
  description = "Region to deploy this pattern into"
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
variable "job" {
  description = "Resource role functional job description"
  type        = string
  default     = ""
}
variable "network" {
  description = "network of the GKE resource"
}
variable "subnet" {
  description = "subnet of the GKE resource"
}