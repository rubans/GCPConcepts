data "google_iam_role" "role" {
  name = var.role
}

resource "google_organization_iam_custom_role" "custom_role" {
  role_id     = var.role_id
  org_id      = var.org_id
  title       = var.title
  description = var.description
  permissions = setsubtract(concat(data.google_iam_role.sm.included_permissions, var.additional_sm_permissions), var.remove_permissions)
}
