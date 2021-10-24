variable "project_id" {
  description = "The project the instance is created in"
}

variable "region"{
  description = "Region in which vm will be created"
}

variable "zone"{
  description = "Zone in which vm will be created"
}

variable "machine_type"{
  description = "machine type of the vm"
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

variable "image"{
  description = "VM Image to be used"
}

# variable "network_name"{
#   description = "Network Name"
# }


# variable "subnetwork_name"{
#   description = "SubNetwork Name"
# }

