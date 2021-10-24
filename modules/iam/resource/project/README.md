# GCP Project Identity and Access Management

These modules are helper modules to create IAM bindings between resources, roles and members. These modules are usually used by the resource modules themselves, by passing the relevant parameters (iam_method, iam_bindings and audit_configs), or directly by passing these same parameters and the resource identifier. 

There are three different ways in which IAM bindings can be applied to resources:
* policy  - creates a policy and assigns to a resource, completely replacing any previous bindings (authoritative at resource level)
* bindings - creates bindings and assigns them to a resource, replacing previous bindings (authoritative at role level)
* members  - creates individual bindings and assigns them to a resource, does not replace any previous bindings (additive)
## Usage

The following examples show how to assign IAM bindings to a project.
* Option 1 applies the IAM roles to the project in the resource module, the binding method depends on the value of the iam_method variable (POLICY|BINDINGS|MEMBERS)
* Option 2 applies the IAM roles to the project specified by the project, the binding method depends on the value of the iam_method variable (POLICY|BINDINGS|MEMBERS)
* Option 3 applies the IAM roles to the project specified by the project using an authoritative policy binding. This replaces all other bindings
* Option 4 applies the IAM roles to the project specified by the project using authoritative bindings for each role. This replaces bindings for the specified roles
* Option 5 applies the IAM roles to the project specified by the project using an additive approach. Existing bindings are not changed  


```hcl
// Option 1 - Assign IAM bindings to the project as part of the project module

module "project" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//resources/project"

  name            = "<<proj-name>>"
  folder_id       = "<<folder-id>>"
  billing_account = "<<billing-account>>"

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

// Option 2 - Assign IAM bindings to the project as part of the iam project module

module "project_iam" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/project"

  project = "<<project-id>>"

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

// Option 3 - Assign IAM bindings to the project using iam project policy

module "project_iam_policy" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/project/policy"

  project = "<<project-id>>"

  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
  audit_configs = {
    "allServices" = ["ADMIN_READ", "DATA_READ", "DATA_WRITE"]
  }
}

// Option 4 - Assign IAM bindings to the project using iam project bindings

module "project_iam_bindings" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/project/bindings"

  project = "<<project-id>>"

  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
  audit_configs = {
    "allServices" = ["ADMIN_READ", "DATA_READ", "DATA_WRITE"]
  }
}

// Option 5 -Assign IAM bindings to the project using iam project members

module "project_iam_members" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/project/members"

  project = "<<project-id>>"

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

| Name          | Description                                                        | Type                 | Default | Required |
|---------------|--------------------------------------------------------------------|----------------------|---------|----------|
| project       | The fully qualified name of the project                            | `string`             | n/a     | yes      |
| iam_method    | Method to apply IAM bindings to resources                          | `string`             | MEMBER  | no       |
| iam_bindings  | A map of members and roles to apply to the service account         | `map(list(string))`  | n/a     | no       |

## Outputs

