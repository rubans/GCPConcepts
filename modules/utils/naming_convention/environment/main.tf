variable "environment" {
  description = "must be a known environment"
  validation {
    condition = (
        contains(["dev", "test", "staging", "prod"], var.environment) == true
      )
    error_message = "The environment must match one of the above values."
  }
}