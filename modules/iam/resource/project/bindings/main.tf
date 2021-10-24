/**
 * 
 * This module uses an authoritative approach to doing project iam bindings. It takes
 * a map of members with a list of roles and binds the members to the roles. Any members
 * not defined here are removed from the binding but any roles not defined here are not
 * impacted (i.e. if there are any role bindings not in the var.bindings input then
 * they are not removed) 
 * 
 * Improvements: - add conditional bindings
 *               - add audit configs (these can be done separately though)
 *
 */

locals {
  inverted_bindings = transpose(var.iam_bindings)
}

resource "google_project_iam_binding" "bindings" {
  for_each = local.inverted_bindings

  project = var.project

  role    = each.key
  members = each.value
}

resource "google_project_iam_audit_config" "bindings" {
  for_each = var.audit_configs

  project = var.project
  service = each.key

  dynamic audit_log_config {
    for_each = each.value

    content {
      log_type = audit_log_config.value
    }
  }
}
