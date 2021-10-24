locals {
  organization   = var.policy_level == "organization"
  folder         = var.policy_level == "folder"
  project        = var.policy_level == "project"
  enable         = var.enable
}

/******************************************
  Organization policy
 *****************************************/
resource "google_organization_policy" "org_policy_boolean" {
  count = local.enable && local.organization ? 1: 0

  org_id     = var.org_id
  constraint = var.constraint

  boolean_policy {
    enforced = true
  }
}

/******************************************
  Folder policy
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_boolean" {
  count = local.enable && local.folder ? 1: 0

  folder     = var.folder_id
  constraint = var.constraint

  boolean_policy {
    enforced = true
  }
}

/******************************************
  Project policy
 *****************************************/
resource "google_project_organization_policy" "project_policy_boolean" {
  count = var.enable && local.project ? 1: 0

  project    = var.project_id
  constraint = var.constraint

  boolean_policy {
    enforced = true
  }
}
