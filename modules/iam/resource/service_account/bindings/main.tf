/**
 * 
 * This module uses an authoritative approach to doing iam bindings. It takes
 * a map of members with a list of roles and binds the members to the roles. Any members
 * not defined here are removed from the binding but any roles not defined here are not
 * impacted (i.e. if there are any role bindings not in the var.bindings input then
 * they are not removed) 
 * 
 * Improvements: - add conditional bindings
 *
 */

locals {
  inverted_bindings = transpose(var.iam_bindings)
}

resource "google_service_account_iam_binding" "bindings" {
  for_each = local.inverted_bindings

  service_account_id = var.account_id

  role    = each.key
  members = each.value
}
