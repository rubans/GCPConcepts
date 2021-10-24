variable "project_id" {
  description = "The project the instance is created in"
}

variable "region"{
  description = "Region in which vm will be created"
}

variable "zone"{
  description = "Zone in which cluster will be created"
}

variable "service_account" {
  type = object({
    email  = string
    scopes = set(string)
  })
  description = "Service account to attach to the instance."
}

variable "kms_key_self_link"{
  description = "kms key self link for vm boot disk"
}

