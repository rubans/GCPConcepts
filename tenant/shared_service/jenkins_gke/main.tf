locals {
  message               = "Welcome CI\\\\CD server.  This Jenkins is configured and managed 'as code'."
  service_account_id    = "jenkins-sa"
  service_account_email = "${local.service_account_id}@${var.project}.iam.gserviceaccount.com"
  jenkins_admin_password = "changeme"
  project                = {
    project_id = var.project
  }
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

provider "helm" {
  kubernetes {
    host  = "https://${data.google_container_cluster.default.endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(
      data.google_container_cluster.default.master_auth[0].cluster_ca_certificate,
    )
  }
}

# create SA - TO DO : may need to be  moved outside
module "google_service_account" {
  source        = "../../../modules//iam/service_account/"
  display_name  = local.service_account_id
  description   = local.service_account_id
  project       = local.project
  roles         = ["roles/compute.admin"]
  account_id    = local.service_account_id
}

module "create-cluster" {
  source          = "../../../modules//compute/kubernetes"
  project         = var.project
  region          = var.region
  prefix          = var.prefix
  tenant_name     = var.tenant_name
  environment     = var.environment
  depends_on      = [module.google_service_account]
  service_account = local.service_account_email
  node_count      = 2
  network         = var.network.id
  subnetwork      = var.subnet.id
  cluster_secondary_range = var.subnet.secondary_ip_range[0].range_name
  services_secondary_range = var.subnet.secondary_ip_range[1].range_name
}

module "workload_identity" {
  source          = "../../utils/sa"
  project         = var.project
  service_account_id = local.service_account_id
  applications = {"jenkins":"jenkins"}
  depends_on = [module.create-cluster]
}


# module "psp" {
#   source          = "../../utils/psp"
#   service_account_id = local.service_account_id
#   applications = {"jenkins":"jenkins"}
#   depends_on = [module.workload_identity]
# }


# # TODO correct with ksa
# resource "helm_release" "jenkins" {
#   name       = "my-jenkins-release"
#   chart      = "jenkins/jenkins"
#   # TODO find a better way to access properties
#   namespace  = "jenkins" #kubernetes_namespace.jenkins-namespace.metadata[0].name 
#   depends_on = [module.psp]
#   version    = "3.5.9"
#   values = [
#      templatefile("${path.module}/jenkins/values.yaml", { message = local.message, jenkins-admin-password = local.jenkins_admin_password, jenkins-ksa = "ksa-jenkins" })
#   ]
# }

