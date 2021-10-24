/**
 * 
 * This module uses an additive approach to doing organization iam bindings. It takes
 * a map of members with a list of roles and binds the individual members to the roles.
 * This approach will manage the member roles that are defined here but will not
 * manage any role/members added or removed outside of terraform
 * 
 * Improvements: - add conditional bindings
 *
 */

resource "google_organization_iam_member" "member_role" {
  count = length(var.iam_roles)

  org_id = var.org_id

  member = var.iam_member
  role   = var.iam_roles[count.index]
}

resource "google_organization_iam_audit_config" "bindings" {
  for_each = var.audit_configs

  org_id  = var.org_id
  service = each.key

  dynamic audit_log_config {
    for_each = each.value

    content {
      log_type = audit_log_config.value
    }
  }
}
