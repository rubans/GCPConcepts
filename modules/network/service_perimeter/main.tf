resource "google_access_context_manager_service_perimeter" "perimeter" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.platform.name}"
  name   = "accessPolicies/${google_access_context_manager_access_policy.platform.name}/servicePerimeters/perimeter"
  title  = "perimeter"
  status {
    restricted_services     = var.restricted_services
    resources = [
      "projects/${var.project_id}"
    ]
    access_levels = [
      google_access_context_manager_access_level.access_level.name
    ]
  }

  depends_on = [
    google_access_context_manager_access_policy.platform,
  ]
}

resource "google_access_context_manager_access_level" "access_level" {
  parent = "accessPolicies/${google_access_context_manager_access_policy.platform.name}"
  name   = "accessPolicies/${google_access_context_manager_access_policy.platform.name}/accessLevels/orchestration_cloud_build"
  title  = "orchestration-cloud-build"
  basic {
    conditions {
      members = var.perimeter_members
    }
  }

  depends_on = [google_access_context_manager_access_policy.platform]
}

resource "google_access_context_manager_access_policy" "platform" {
  parent = "organizations/${var.org_id}"
  title  = "platform-policy"
}
