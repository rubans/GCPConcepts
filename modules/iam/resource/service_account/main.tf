//Use additive binding at the member level 
module members_iam {
  source = "./members"
  count  = var.iam_method == "MEMBERS" ? 1 : 0

  account_id = var.account_id

  iam_bindings = var.iam_bindings
}

//Use additive binding for a single member - this is a "hack" because of limitations in for_each loops
/*module member_iam {
  source = "./member"
  count  = var.iam_method == "MEMBER" ? 1 : 0

  account_id = var.account_id

  iam_bindings = var.iam_bindings
}*/

//Use authoritative binding at the role level
module bindings_iam {
  source = "./bindings"
  count  = var.iam_method == "BINDINGS" ? 1 : 0

  account_id = var.account_id

  iam_bindings = var.iam_bindings
}

//Use authoritative binding at the policy level
module policy_iam {
  count  = var.iam_method == "POLICY" ? 1 : 0
  source = "./policy"

  account_id = var.account_id

  iam_bindings = var.iam_bindings
}
