/**
 * 
 * This module creates an IAM policy from a map of members with a list of roles and
 * assigns it to a service account to create an authoritative approach to IAM bindings
 * 
 * This provides an authoritative approach to applying IAM permissions to a resource
 * that ensures all other IAM role bindings are removed. Care must be taken to ensure
 * it does includes any defaulted google IAM bindings that are created automatically
 * 
 * Improvements: - add conditional bindings
 *               - add audit configs (these can be done separately though)
 *
 */

module "iam" {
  source = "../../../policy"

  iam_bindings  = var.iam_bindings
}

resource "google_sourcerepo_repository_iam_policy" "policy" {
  repository  = var.repository
  policy_data = module.iam.policy.policy_data
}

