/***********************************************
 Client Organization
***********************************************/
module organization {
  source = "../../../modules//resource/organization"
  domain = var.domain
}

/***********************************************
 Tenant folder
***********************************************/

module folder_tenant_shared_services{
  source = "../../../modules//resource/folder"
  name = "${var.prefix}-${var.tenant_name}"
  parent = module.organization.organization.id
}

/*********************************************************
  Service Account - tenant shared services service account 
**********************************************************/

module tenant_shared_services_sa {
  source = "../../../modules//resource/service_account"

  project      = module.project_tenant_shared_services.project.project_id
  account_id   = "foldermgmtservice-acct"
  display_name = "tenant_mgmt_folder-sa"
  description  = "Tenantmgmt_Service_Account"
}

/**********************************************************
 Create a tenant shared services project and relevant APIs
 **********************************************************/
module project_tenant_shared_services {
  source          = "../../../modules//resource/project"
  name            = "${var.prefix}-${var.tenant_name}-shared-svc"
  folder_id       = module.folder_tenant_shared_services.folder.id
  billing_account = var.billing_account

  services = [
  
    "compute.googleapis.com",              # Compute Engine API
    "iam.googleapis.com",                  # Identity and Access Management (IAM) API
    "iamcredentials.googleapis.com",       # IAM Service Account Credentials API
    "storage.googleapis.com",              # Cloud Storage (gcs) API
    "cloudasset.googleapis.com",           # Service endpoint API
    "cloudidentity.googleapis.com",        # For managing users and groups API
    "cloudresourcemanager.googleapis.com", # For Inspec tests API
    "cloudkms.googleapis.com",             # Key management Service API
    "serviceusage.googleapis.com",         # Service Usage API
    "secretmanager.googleapis.com",        # secrets build and management API
    "container.googleapis.com"             # Kubernetes API
  ]
}

/**********************************************************
 Create a tenant workload project and relevant APIs
 **********************************************************/
module project_tenant_workloads {
  source          = "../../../modules//resource/project"
  name            = "${var.prefix}-${var.tenant_name}-workloads"
  folder_id       = module.folder_tenant_shared_services.folder.id
  billing_account = var.billing_account

  services = [
  
    "compute.googleapis.com",              # Compute Engine API
    "iam.googleapis.com",                  # Identity and Access Management (IAM) API
    "iamcredentials.googleapis.com",       # IAM Service Account Credentials API
    "storage.googleapis.com",              # Cloud Storage (gcs) API
    "cloudasset.googleapis.com",           # Service endpoint API
    "cloudidentity.googleapis.com",        # For managing users and groups API
    "cloudresourcemanager.googleapis.com", # For Inspec tests API
    "serviceusage.googleapis.com",         # Service Usage API
    "container.googleapis.com"             # Kubernetes API
  ]
}

/***********************************************
  Create Tenant's Terraform-State-bucket
 ***********************************************/

module tenant_tfstate_bucket {
  source = "../../../modules//storage/bucket"

  project = module.project_tenant_shared_services.project.project_id
  description   = "tstate_bucket"
  location      = var.region
  storage_class = "STANDARD"
  prefix        = var.prefix
  tenant_name   = var.tenant_name
  environment   = var.environment 

  labels = {
    "owner"              = "cap_tenant_mgmtprj"
    "cost_centre"        = "corporate"
    "dataclassification" = "highlyconfidential"
  }

  depends_on = [module.project_tenant_shared_services]
}

/***********************************************
 Create tenant Secret project and relevant APIs
 ***********************************************/

module project_tenant_secrets {
  source = "../../../modules//resource/project"
  name   = "${var.prefix}-${var.tenant_name}-secrets"
  folder_id       = module.folder_tenant_shared_services.folder.id
  billing_account = var.billing_account

  services = [
    "cloudasset.googleapis.com",    # Service endpoint API
    "cloudkms.googleapis.com",      # Key management Service API
    "serviceusage.googleapis.com",  # Service Usage API
    "secretmanager.googleapis.com", # secrets build and management API
    "compute.googleapis.com"        # Compute Engine API
  ]
}

module project_tenant_secrets_iam {
  source = "../../../modules//iam/resource/project/member"

  # Assign role(s) to service account
  project    = module.project_tenant_secrets.project.project_id
  iam_member = "serviceAccount:${module.tenant_shared_services_sa.account.email}"
  iam_roles = [
    "roles/owner"
  ]
}

/***********************************************
 Create tenant Network project and relevant APIs
 ***********************************************/

# create tenant shared VPC project
module project_tenant_shared_vpc {
  source = "../../../modules//resource/project"
  name   = "${var.prefix}-${var.tenant_name}-shared-vpc"
  folder_id       = module.folder_tenant_shared_services.folder.id
  billing_account = var.billing_account
  services = [
    "servicenetworking.googleapis.com"    # Service Networking API
  ]
}
  
/*****************************************************************
 Create tenant Spoke Networking Shared VPC and dependencies
 *****************************************************************/
locals {
  # defined service projects to attach to spoke VPC and required subnets per resources
  service_projects = [
    {
      project = module.project_tenant_secrets.project
    },
    {
      project = module.project_tenant_shared_services.project
      subnet = {
        job = "gke-shared-service",
        region = var.region
        ip_range = "192.168.192.0/23"
        secondary_ip_range = [
          {
            range_name    = "gkepods"
            ip_cidr_range = "192.168.128.0/19"
          },
          {
            range_name    = "gkeservices"
            ip_cidr_range = "192.168.208.0/21"
          }
        ]
      }
    },
    {
      project = module.project_tenant_workloads.project
      subnet = {
        job = "gke-workload",
        region = var.region,
        ip_range = "192.168.194.0/23"
        secondary_ip_range = [
          {
            range_name    = "gkepods"
            ip_cidr_range = "192.168.0.0/19"
          },
          {
            range_name    = "gkeservices"
            ip_cidr_range = "192.168.216.0/21"
          }
        ]
      }
    }
  ]
}

module setup_shared_vpc {
  source = "./networking"
  prefix = var.prefix
  environment = var.environment
  tenant_name = var.tenant_name
  billing_account = var.billing_account
  host_project = module.project_tenant_shared_vpc.project
  service_projects = local.service_projects
}
