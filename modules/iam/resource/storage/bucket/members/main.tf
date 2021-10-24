/**
 * 
 * This module uses an additive approach to doing folder iam bindings. It takes
 * a map of members with a list of roles and binds the individual members to the roles.
 * This approach will manage the member roles that are defined here but will not
 * manage any role/members added or removed outside of terraform
 * 
 * Improvements: - add conditional bindings
 *               - add audit configs exemptions
 *
 */

locals {
  member_roles = flatten([
    for member, roles in var.iam_bindings : [
      for role in roles : {
        member = member
        role   = role
      }
    ]
  ])

  member_role_map = {
    for member_role in local.member_roles : "${member_role.member}/${member_role.role}" => {
      member = member_role.member
      role   = member_role.role
    }
  }
}

resource "google_storage_bucket_iam_member" "member_role" {
  for_each = local.member_role_map

  bucket = var.bucket_name

  role   = each.value.role
  member = each.value.member
}
