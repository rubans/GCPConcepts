variable "prefix" {
  description = "3 character prefix for the tenant"
  type        = string
}

variable "project" {
  description = "The project that the key belongs to - the whole project object."
  type        = string
}

variable "env" {
  description = "Single char representing the environment the resource is in. For example, d for dev"
  type        = string
}

variable "description" {
  description = "Up to 20 alphanumeric characters describing what the resource is for. E.g. frontend or backend"
  type        = string
}

variable "location" {
  description = "The location of the keyring."
  type        = string
  validation {
    condition = (
      contains(["asia", "asia-east1", "asia-east2", "asia-northeast1", "asia-northeast2", "asia-northeast3", "asia-south1",
               "asia-south2", "asia-southeast1", "asia-southeast2", "asia1", "australia-southeast1", "australia-southeast2",
               "eur3", "eur4", "eur5", "europe", "europe-central2", "europe-north1", "europe-west1", "europe-west2", 
               "europe-west3", "europe-west4", "europe-west6", "global", "nam3", "nam4", "nam6", "nam9",
               "northamerica-northeast1", "northamerica-northeast2", "southamerica-east1", "us", "us-central1",
               "us-east1", "us-east4", "us-west1", "us-west2", "us-west3", "us-west4"], var.location) == true
      )
      error_message = "The location of the keyring must match one of the above values."
  }
}

variable "rotation_period" {
  description = "The rotation period for the key, in seconds. Default is 90 days. Set to null to disable key rotation (preferable for Cloud SQL currently)."
  type        = string
  default     = "7776000s"
}

variable "purpose" {
  description = "The purpose of the key"
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "algorithm" {
  description = "The algorithm to use for encryption/decryption"
  type        = string
  default     = "GOOGLE_SYMMETRIC_ENCRYPTION"
}

variable "protection_level" {
  description = "Software or HSM"
  type        = string
  default     = "HSM"
}

variable "labels" {
  description = "Labels (in addition to the defaults)"
  type        = map(string)
  default     = {}
}
