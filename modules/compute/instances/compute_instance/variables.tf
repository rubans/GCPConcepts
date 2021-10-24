variable "project" {
  description = "The project the instance is created in"
}

variable "name"{
  description = "Name of the vm"
}

variable "zone"{
  description = "Zone in which vm will be created"
}

variable "machine_type"{
  description = "machine type of the vm"
}

variable "allow_stopping_for_update"{
  description = "allow stopping vm for update"
  default = true
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

variable "network_name"{
  description = "Network Name"
}


variable "subnetwork_name"{
  description = "SubNetwork Name"
}

variable "shielded_instance_config" {
  description = "Not used unless enable_shielded_vm is true. Shielded VM configuration for the instance."
  type = object({
    enable_secure_boot          = bool
    enable_vtpm                 = bool
    enable_integrity_monitoring = bool
  })

  default = {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}

variable "metadata"{
  description = "metadata"
  default = {
    block-project-ssh-keys = true
    serial-port-enable     = false
    enable-oslogin         = true
  }
}

variable "extra_metadata"{
  description = "extra metadata"
  default = {}
}

variable "enable_shielded_vm" {
  description = "enable shielded vm"
  default = true
}
