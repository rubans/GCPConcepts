# GCP Organisation Identity and Access Management

These modules are helper modules to create IAM bindings between resources, roles and members. These modules are usually used by the resource modules themselves, by passing the relevant parameters (iam_method, iam_bindings and audit_configs), or directly by passing these same parameters and the resource identifier. 

There are three different ways in which IAM bindings can be applied to resources:
* policy  - creates a policy and assigns to a resource, completely replacing any previous bindings (authoritative at resource level)
* bindings - creates bindings and assigns them to a resource, replacing previous bindings (authoritative at role level)
* members  - creates individual bindings and assigns them to a resource, does not replace any previous bindings (additive)
## Usage

The following examples show how to assign IAM bindings to an organisation. The same process can be used for any resource. 
* Option 1 applies the IAM roles to the organization in the resource module, the binding method depends on the value of the iam_method variable (POLICY|BINDINGS|MEMBERS)
* Option 2 applies the IAM roles to the organizaiton specified by the org_id, the binding method depends on the value of the iam_method variable (POLICY|BINDINGS|MEMBERS)
* Option 3 applies the IAM roles to the organization specified by the org_id using an authoritative policy binding. This replaces all other bindings
* Option 4 applies the IAM roles to the organization specified by the org_id using authoritative bindings for each role. This replaces bindings for the specified roles
* Option 5 applies the IAM roles to the organization specified by the org_id using an additive approach. Existing bindings are not changed  


```hcl
// Option 1 - Assign IAM bindings to an organization as part of the organization module

module "organization" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//resources/organization"

  domain = "gcp-foundation.com"

  iam_method   = "POLICY"
  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
  audit_configs = {
    "allServices" = ["ADMIN_READ", "DATA_READ", "DATA_WRITE"]
  }
}

// Option 2 - Assign IAM bindings to an organization using the iam organization module

module "organization_iam" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/organization"

  org_id = module.organization.organization.org_id

  iam_method   = "POLICY"
  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
  audit_configs = {
    "allServices" = ["ADMIN_READ", "DATA_READ", "DATA_WRITE"]
  }
}

// Option 3 - Assign IAM bindings to an organization using the iam organization policy module

module "organization_iam_policy" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/organization/policy"

  org_id = module.organization.organization.org_id

  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
  audit_configs = {
    "allServices" = ["ADMIN_READ", "DATA_READ", "DATA_WRITE"]
  }
}

// Option 4 - Assign IAM bindings to an organization using the iam organization bindings module

module "organization_iam_bindings" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/organization/bindings"

  org_id = module.organization.organization.org_id

  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
  audit_configs = {
    "allServices" = ["ADMIN_READ", "DATA_READ", "DATA_WRITE"]
  }
}

// Option 5 - Assign IAM bindings to an organization using the iam organization members module
module "organization_iam_members" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/organization/members"

  org_id = module.organization.organization.org_id

  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }

  audit_configs = {
    "allServices" = ["ADMIN_READ", "DATA_READ", "DATA_WRITE"]
  }
}
```
## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.13
- Terraform Provider for GCP plugin >=v3.30

## Inputs

## Outputs

