// Need to improve this approach to ensure that projects can be deleted and recreated easily.
resource "random_id" "project_suffix" {
  byte_length = 2
}

locals {
  project_id = format("%s-%s", var.name, random_id.project_suffix.hex)
}

/***********************************************
  Create the project
 ***********************************************/

resource "google_project" "project" {
  name                = var.name
  project_id          = local.project_id
  folder_id           = var.folder_id
  billing_account     = var.billing_account
  skip_delete         = var.skip_delete
  auto_create_network = var.auto_create_network
  labels              = var.labels
}

/***********************************************
  If type is HOST then enable as a VPC host project
 ***********************************************/

resource "google_compute_shared_vpc_host_project" "host" {
  count   = var.project_type == "HOST" ? 1 : 0
  project = google_project.project.project_id
}

/***********************************************
  If type is SERVICE then connect as a service project to VPC host project
 ***********************************************/

resource "google_compute_shared_vpc_service_project" "shared" {
  count           = var.project_type == "SERVICE" ? 1 : 0
  host_project    = var.host_project_id
  service_project = google_project.project.project_id
}

/***********************************************
  Enable services
 ***********************************************/

resource "google_project_service" "services" {
  for_each = toset(var.services)
  project  = google_project.project.project_id
  service  = each.key

  disable_on_destroy         = false
  disable_dependent_services = false
}

/***********************************************
  Enforce OS Login on all projects
 ***********************************************/

resource "google_compute_project_metadata" "metadata" {
  project = google_project.project.project_id
  metadata = {
    enable-oslogin = var.oslogin
  }
}

/***********************************************
  Deprevilege project's default service account
 ***********************************************/
resource "google_project_default_service_accounts" "default_sa" {
  project = google_project.project.project_id
  action  = "DEPRIVILEGE"
}

/***********************************************
  Create new service account for project
 ***********************************************/
resource "google_service_account" "service_account" {
  account_id   = google_project.project.project_id
  display_name = "${var.name} project service account"
  description  = "The project's service account"
  project      = google_project.project.project_id
}

/***********************************************
  Assign iam roles to the project
 ***********************************************/
module project_iam {
  source = "../../iam/resource/project"

  project = google_project.project.project_id

  iam_method    = var.iam_method
  iam_bindings  = var.iam_bindings
  audit_configs = var.audit_configs
}

