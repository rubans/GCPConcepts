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
  inverted_bindings = transpose(var.bindings)
}

resource "google_project_iam_binding" "binding" {
  for_each = local.inverted_bindings

  project = var.project
  role    = binding.key
  members = binding.value
}

/* TBD - at the moment this is applied at the organisation level for all services 
resource "google_project_iam_audit_config" "audit_config" {
}
*/
