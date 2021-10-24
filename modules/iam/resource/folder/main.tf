//Use additive binding at the member level 
module folder_iam_member {
  source = "./members"
  count  = var.iam_method == "MEMBERS" ? 1 : 0

  folder = var.folder

  iam_bindings  = var.iam_bindings
  audit_configs = var.audit_configs
}

//Use authoritative bindings at the role level
module folder_iam_binding {
  source = "./bindings"
  count  = var.iam_method == "BINDINGS" ? 1 : 0

  folder = var.folder

  iam_bindings  = var.iam_bindings
  audit_configs = var.audit_configs
}

//Use authoritative bindings 
module folder_iam_policy {
  count  = var.iam_method == "POLICY" ? 1 : 0
  source = "./policy"

  folder = var.folder

  iam_bindings  = var.iam_bindings
  audit_configs = var.audit_configs
}
