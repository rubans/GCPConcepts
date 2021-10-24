variable "applications" {
  description = "App to add to cluster"
  type        = map(string)
  default     = {}
}

variable "service_account_id" {
  description = "Service account"
  type        = string
}

variable "project" {
  description = "Project Id"
  type        = string
}

# variable "cluster_endpoint" {}

# variable "cluster_client_access_token" {}

# variable "cluster_ca_certificate" {}

# Configure kubernetes provider with Oauth2 access token.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config
# This fetches a new token, which will expire in 1 hour.
# data "google_client_config" "default" {
#   depends_on = [module.create-cluster]
# }

# provider "kubernetes" {
#   host  = "https://${variable.cluster_endpoint}"
#   token = variable.cluster_client_access_token
#   cluster_ca_certificate = base64decode(
#     variable.cluster_ca_certificate,
#   )
# }

data "google_service_account" "service_account" {
  account_id = var.service_account_id
  project = var.project
}

resource "kubernetes_namespace" "namespace" {
  for_each = toset(values(var.applications))
  metadata {
    name = each.value
  }

}

resource "kubernetes_service_account" "jenkins-ksa" {
  for_each = var.applications
  metadata {
    name        = "ksa-${each.key}"
    namespace   = each.value
    annotations = { "iam.gke.io/gcp-service-account" : data.google_service_account.service_account.email }
  }

}

resource "google_service_account_iam_binding" "admin-account-iam" {
  for_each = var.applications
  service_account_id = data.google_service_account.service_account.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${var.project}.svc.id.goog[${each.key}/ksa-${each.value}]",
    # "serviceAccount:${var.project}.svc.id.goog[lookup(${kubernetes_namespace.jenkins-namespace,).metadata[0].name}/${kubernetes_service_account.jenkins-ksa.metadata[0].name}]",
  ]
}
