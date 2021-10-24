//Use additive binding at the member level 
module storage_bucket_iam_member {
  source = "./members"
  count  = var.iam_method == "MEMBERS" ? 1 : 0

  bucket_name = var.bucket_name
  iam_bindings  = var.iam_bindings
}

//Use authoritative bindings at the role level
module storage_bucket_iam_binding {
  source = "./bindings"
  count  = var.iam_method == "BINDINGS" ? 1 : 0

  bucket_name = var.bucket_name
  iam_bindings  = var.iam_bindings
}

//Use authoritative bindings 
module storage_bucket_iam_policy {
  count  = var.iam_method == "POLICY" ? 1 : 0
  source = "./policy"

  bucket_name = var.bucket_name
  iam_bindings  = var.iam_bindings
}
