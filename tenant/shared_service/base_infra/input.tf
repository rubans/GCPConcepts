variable "domain" {
  description = "The domain url to seed"
  type        = string
}

variable "billing_account" {
  description = "The billing account for the organisation"
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

variable "region" {
  description = "The region for the seed and pipeline project"
  type        = string
}

variable "prefix" {
  description = "Prefix for uniquely naming resources"
  type        = string
  default     = "cap"
}

variable "terraform_service_account" {
  description = "The service account to use for the organisation level terraform"
  type        = string
  default     = null
}
