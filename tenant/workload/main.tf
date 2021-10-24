locals {
  service_account_id    = "jenkins-sa"
  service_account_email = "${local.service_account_id}@${var.project}.iam.gserviceaccount.com"
}

# Provider is configured using environment variables: GOOGLE_REGION, GOOGLE_PROJECT, GOOGLE_CREDENTIALS.
# This can be set statically, if preferred. See docs for details.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#full-reference
provider "google" {
  project = var.project
  region  = var.region
}


# Configure kubernetes provider with Oauth2 access token.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config
# This fetches a new token, which will expire in 1 hour.
data "google_client_config" "default" {
  depends_on = [module.create-cluster]
}

# Defer reading the cluster data until the GKE cluster exists.
data "google_container_cluster" "default" {
  name       = module.create-cluster.kubernetes_cluster_name
  location   = var.region
  project    = var.project
  depends_on = [module.create-cluster]
}


provider "kubernetes" {
  host  = "https://${data.google_container_cluster.default.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.default.master_auth[0].cluster_ca_certificate,
  )
}


module "create-cluster" {
  source          = "../../modules//compute/kubernetes"
  project         = var.project
  region          = var.region
  prefix          = var.prefix
  tenant_name     = var.tenant_name
  environment     = var.environment
  service_account = local.service_account_email
  node_count      = 2
  network         = var.subnet.network
  subnetwork      = var.subnet.name
  cluster_secondary_range = var.subnet.secondary_ip_range[0].range_name
  services_secondary_range = var.subnet.secondary_ip_range[1].range_name
}


module "workload_identity" {
  source          = "../utils/sa"
  project         = var.project
  service_account_id = var.service_account_id
  applications = var.applications
  depends_on = [module.create-cluster]
}


module "psp" {
  source          = "../utils/psp"
  service_account_id = var.service_account_id
  applications = var.applications
  depends_on = [module.workload_identity]
}



