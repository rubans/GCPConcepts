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

module "policy" {
  source = "../../../policy"

  iam_bindings = var.iam_bindings
}

resource "google_service_account_iam_policy" "policy" {
  service_account_id = var.account_id
  policy_data        = module.policy.policy.policy_data
}
