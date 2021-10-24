variable "environment_abbr" {
  validation {
    condition     = alltrue([
        can(regex("^[a-z]+$", var.environment_abbr)),
        length(var.environment_abbr) == 1
      ]) 
    error_message = "The environment_abbr value must be a valid."
  }
}
variable "prefix" {
  validation {
    condition     = alltrue([
        can(regex("^[a-z]+$", var.prefix)),
        length(var.prefix) == 3
      ]) 
    error_message = "The prefix value must be a valid."
  }
}
variable "suffix" {
  validation {
    condition     = alltrue([
        can(regex("^[0-9a-z]+$", var.suffix)),
        length(var.suffix) == 4
      ]) 
    error_message = "The suffix value must be a valid."
  }
}
variable "resource_type_abbr" {
  validation {
    condition     = alltrue([
        can(regex("^[a-z]+$", var.resource_type_abbr)),
        length(var.resource_type_abbr) == 3
      ]) 
    error_message = "The resource_type_abbr value must be a valid."
  }
}
variable "location_abbr" {
  type = string
  default = ""
  validation {
    # condition = can(var.location_abbr == null 
    #   || (var.location_abbr != null && regex("^[0-9a-z]+$", var.location_abbr))
    # )
    condition     = anytrue([
        anytrue([
          var.location_abbr == ""
        ]),
        alltrue([
          can(regex("^[0-9a-z]+$", var.location_abbr)),
          length(var.location_abbr) >= 1 && length(var.location_abbr) <= 6
        ])
    ])
    error_message = "The location_abbr value must be a valid."
  }
}
variable "tenant_name" {
  validation {
    condition     = alltrue([
        can(regex("^[0-9a-z]+$", var.tenant_name)),
        length(var.tenant_name) >= 4 && length(var.tenant_name) <= 10
      ]) 
    error_message = "The tenant_name value must be a valid."
  }
}
variable "job" {
  default = ""
  validation {
    condition     = anytrue([
        anytrue([
          var.job == ""
        ]),
        alltrue([
          can(regex("^[0-9a-z]+$", var.job)),
          length(var.job) >= 1 && length(var.job) <= 20
        ]) 
    ])
    error_message = "The tenant_name value must be a valid."
  }
}
