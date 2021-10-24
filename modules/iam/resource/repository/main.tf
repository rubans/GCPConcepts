//Use additive binding at the member level 
module repository_iam_member {
  source = "./members"
  count  = var.iam_method == "MEMBERS" ? 1 : 0

  repository = var.repository
  iam_bindings  = var.iam_bindings
}

//Use authoritative bindings at the role level
module repository_iam_binding {
  source = "./bindings"
  count  = var.iam_method == "BINDINGS" ? 1 : 0

  repository = var.repository
  iam_bindings  = var.iam_bindings
}

//Use authoritative bindings 
module repository_iam_policy {
  count  = var.iam_method == "POLICY" ? 1 : 0
  source = "./policy"

  repository = var.repository
  iam_bindings  = var.iam_bindings
}
