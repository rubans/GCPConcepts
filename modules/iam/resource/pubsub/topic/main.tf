//Use additive binding at the member level 
module pubsub_topic_iam_member {
  source = "./members"
  count  = var.iam_method == "MEMBERS" ? 1 : 0

  topic   = var.topic
  project = var.project

  iam_bindings  = var.iam_bindings
}

//Use authoritative bindings at the role level
module pubsub_topic_iam_binding {
  source = "./bindings"
  count  = var.iam_method == "BINDINGS" ? 1 : 0

  topic   = var.topic
  project = var.project

  iam_bindings  = var.iam_bindings
}

//Use authoritative bindings 
module pubsub_topic_iam_policy {
  count  = var.iam_method == "POLICY" ? 1 : 0
  source = "./policy"

  topic   = var.topic
  project = var.project

  iam_bindings  = var.iam_bindings
}
