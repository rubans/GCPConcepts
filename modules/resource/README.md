# Resource 

These modules enable the management of organisations, folders, projects and service accounts. The organisation module is used to import an existing organisation object using it's primary domain identifier and enables the IAM groups be to assigned roles. The folder module creates folders under an organisation or another folder and enables IAM groups to be assigned roles. The projects module creates projects, enables services and assigns IAM roles to the members. The service account module enables creation of a service account resource.

## Usage

Basic usage of this module is as follows:

```hcl
// Obtain the organization data object using the domain and set IAM permissions using policy level authoritative binding
module "organization" {
  source  = "git::ssh://git@github.com/ps-gcp-foundation/modules//resource/organization"

  domain = var.domain

  iam_method = "POLICY"
  iam_bindings = {
    "user:admin@gcp-foundation.com" = [
      "roles/billing.costsManager",
      "roles/iam.securityAdmin",
      "roles/iam.serviceAccountCreator",
      "roles/orgpolicy.policyAdmin",
      "roles/owner",
      "roles/resourcemanager.folderCreator",
      "roles/resourcemanager.organizationAdmin",
      "roles/securitycenter.admin",
    ],
    "group:gcp-organization-admins@gcp-foundation.com" = [
      "roles/billing.user",
      "roles/resourcemanager.organizationAdmin",
      "roles/resourcemanager.projectCreator",
      "roles/serviceusage.serviceUsageConsumer",
    ],
  }

  audit_configs = {
    "allServices" = ["ADMIN_READ", "DATA_READ", "DATA_WRITE"]
  }
}

// Create the common folder as a child of the organization, setting IAM permissions using member level additive bindings
module "folder_common" {
  source  = "git::ssh://git@github.com/ps-gcp-foundation/modules//resource/folder"

  name   = "common"
  parent = module.organization.organization.org_id

  iam_method = "MEMBER"
  iam_bindings = {
    "group:gcp-devops@gcp-foundation.com" = ["roles/resourcemanager.folderAdmin"]
  }
}

// Create the logging folder as a child of the common folder, setting IAM permissions using role level authoritative bindings 
module "folder_logging" {
  source  = "git::ssh://git@github.com/ps-gcp-foundation/modules//resource/folder"
  
  name   = "logging"
  parent = module.folder_common.folder.id
}

// Create the logging project in the logging folder, setting IAM permissions using member level additive bindings
module "project_logging" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//resource/project"

  name = "logging"
  parent = module.folder_logging.folder.id

  services = []

  iam_method = "MEMBER"
  iam_bindings = {
    "group:gcp-devops@gcp-foundation.com" = ["roles/owner"]
  }
}

// Create the logging project in the logging folder, setting IAM permissions using member level additive bindings
module "project_cicd" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//resource/project"

  name = "account_cicd"
  parent = module.folder_logging.folder.id

  services = []

  iam_method = "MEMBER"
  iam_bindings = {
    "group:gcp-devops@gcp-foundation.com" = ["roles/owner"]
  }
}

module "terraform_service_account" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//resource/service_account"

  name = "account-terraform"
  project = module.project_cicd.project.project_id

  iam_method   = "POLICY"
  iam_bindings = {
    "serviceAccount:${module.project_cicd.project.project_number}@cloudbuild.gserviceaccount.com" = [
      "roles/iam.serviceAccountTokenCreator"
    ]
  }
}

```

## Requirements

To use this module

### Software

The following dependencies must be available:

- Terraform >=v0.13
- Terraform Provider for GCP plugin >=v2.0