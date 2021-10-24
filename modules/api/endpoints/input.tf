variable "project_id" {
  description = "The project id for this endpoint"
  type        = string
}

variable "name" {
  description = "The name of this service endpoint"
  type        = string
}

variable "specification" {
  description = "The openapi specificationm for this endpoint (yaml file)"
  type        = string
}