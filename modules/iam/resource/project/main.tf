//Use additive binding at the member level 
module project_member_iam {
  source = "./members"
  count  = var.iam_method == "MEMBERS" ? 1 : 0

  project = var.project

  iam_bindings  = var.iam_bindings
  audit_configs = var.audit_configs
}

//Use authoritative binding at the role level
module project_binding_iam {
  source = "./bindings"
  count  = var.iam_method == "BINDINGS" ? 1 : 0

  project = var.project

  iam_bindings  = var.iam_bindings
  audit_configs = var.audit_configs
}

//Use authoritative binding at the policy level
module project_policy_iam {
  count  = var.iam_method == "POLICY" ? 1 : 0
  source = "./policy"

  project = var.project

  iam_bindings  = var.iam_bindings
  audit_configs = var.audit_configs
}
