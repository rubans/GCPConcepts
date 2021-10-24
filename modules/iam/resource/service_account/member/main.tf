/**
 * 
 * This module uses an additive approach to doing service_account iam bindings. It takes
 * a map of members with a list of roles and binds the individual members to the roles.
 * This approach will manage the member roles that are defined here but will not
 * manage any role/members added or removed outside of terraform
 * 
 * Improvements: - add conditional bindings
 *
 */

resource "google_service_account_iam_member" "member_role" {
  count = length(var.iam_roles)

  service_account_id = var.service_account_id

  member = var.iam_member
  role   = var.iam_roles[count.index]
}