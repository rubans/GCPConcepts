data "google_organization" "organization" {
  domain = var.domain
}
module organization_policy_iam {
  source = "../../iam/resource/organization"

  org_id = data.google_organization.organization.org_id

  iam_method    = var.iam_method
  iam_bindings  = var.iam_bindings
  audit_configs = var.audit_configs
}
