resource "google_sourcerepo_repository" "repository" {
  project = var.project
  name    = var.name
  depends_on = [var.module_depends_on]
}

// New IAM approach
module repository_iam {
  source = "../../iam/resource/repository"

  repository = google_sourcerepo_repository.repository.name

  iam_method    = var.iam_method
  iam_bindings  = var.iam_bindings
}
