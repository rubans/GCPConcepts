/**
 * 
 * This module creates an IAM policy from a map of members with a list of roles.
 * The map needs to be inverted because the policy maps a list of members to a role 
 * rather than a list of roles to a member. 
 * 
 * This provides an authoritative approach to applying IAM permissions to a resource
 * that ensures all other IAM role bindings are removed. Care must be taken to ensure
 * it does includes any defaulted google IAM bindings that are created automatically
 * 
 * Improvements: - add conditional bindings
 *               - add audit_config exemptions
 *
 */


locals {
  inverted_bindings = transpose(var.iam_bindings)
}

data "google_iam_policy" "policy" {
  dynamic binding {
    for_each = local.inverted_bindings
    content {
      role    = binding.key
      members = binding.value

      /* TBD condition */
    }
  }

  dynamic audit_config {
    for_each = var.audit_configs

    content {
      service = audit_config.key

      dynamic audit_log_configs {
        for_each = audit_config.value

        content {
          log_type = audit_log_configs.value
        }
      }
    }
  }
}
