/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  dry_run = (length(var.restricted_services_dry_run) > 0 || length(var.resources_dry_run) > 0 || length(var.access_levels_dry_run) > 0)
}

resource "google_access_context_manager_service_perimeter" "regular_service_perimeter" {
  provider       = google
  parent         = "accessPolicies/${var.policy}"
  perimeter_type = "PERIMETER_TYPE_REGULAR"
  name           = "accessPolicies/${var.policy}/servicePerimeters/${var.perimeter_name}"
  title          = var.perimeter_name
  description    = var.description

  status {
    restricted_services = var.restricted_services
    resources           = formatlist("projects/%s", var.resources)
    access_levels = formatlist(
      "accessPolicies/${var.policy}/accessLevels/%s",
      var.access_levels
    )
  }

  dynamic "spec" {
    for_each = local.dry_run ? ["dry-run"] : []
    content {
      restricted_services = var.restricted_services_dry_run
      resources           = formatlist("projects/%s", var.resources_dry_run)
      access_levels = formatlist(
        "accessPolicies/${var.policy}/accessLevels/%s",
        var.access_levels_dry_run
      )
    }
  }
  use_explicit_dry_run_spec = local.dry_run
}