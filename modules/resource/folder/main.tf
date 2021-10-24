resource "google_folder" "folder" {
  display_name = var.name
  parent       = var.parent
}

module folder_iam {
  source = "../../iam/resource/folder"

  folder = google_folder.folder.name

  iam_method    = var.iam_method
  iam_bindings  = var.iam_bindings
  audit_configs = var.audit_configs
}

