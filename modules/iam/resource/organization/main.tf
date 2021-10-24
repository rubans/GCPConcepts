//Use additive binding at the members level 
module organization_members_iam {
  source = "./members"
  count  = var.iam_method == "MEMBERS" ? 1 : 0

  org_id = var.org_id

  iam_bindings  = var.iam_bindings
  audit_configs = var.audit_configs
}

//Use authoritative bindings at the role level
module organization_bindings_iam {
  source = "./bindings"
  count  = var.iam_method == "BINDINGS" ? 1 : 0

  org_id = var.org_id

  iam_bindings  = var.iam_bindings
  audit_configs = var.audit_configs
}

//Use authoritative binding at the policy level
module organization_policy_iam {
  count  = var.iam_method == "POLICY" ? 1 : 0
  source = "./policy"

  org_id = var.org_id

  iam_bindings  = var.iam_bindings
  audit_configs = var.audit_configs
}
