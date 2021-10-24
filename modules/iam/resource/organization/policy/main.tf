/**
 * 
 * This module creates an IAM policy from a map of members with a list of roles.
 * 
 * This provides an authoritative approach to applying IAM permissions to a resource
 * that ensures all other IAM role bindings are removed. Care must be taken to ensure
 * it does includes any defaulted google IAM bindings that are created automatically
 * 
 * Improvements: - add conditional bindings
 *
 */

module "iam" {
  source = "../../../policy"

  iam_bindings  = var.iam_bindings
  audit_configs = var.audit_configs
}

resource "google_organization_iam_policy" "policy" {
  org_id      = var.org_id
  policy_data = module.iam.policy.policy_data
}