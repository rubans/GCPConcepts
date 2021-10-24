# Google IAM Service Account

These modules are helper modules to create IAM bindings between resources, roles and members. These modules are usually used by the resource modules themselves, by passing the relevant parameters (iam_method, iam_bindings and audit_configs), or directly by passing these same parameters and the resource identifier. 

There are three different ways in which IAM bindings can be applied to resources:
* policy  - creates a policy and assigns to a resource, completely replacing any previous bindings (authoritative at resource level)
* bindings - creates bindings and assigns them to a resource, replacing previous bindings (authoritative at role level)
* members  - creates individual bindings and assigns them to a resource, does not replace any previous bindings (additive)
## Usage

The following examples show how to assign IAM bindings to a service_account.
* Option 1 applies the IAM roles to the service_account in the resource module, the binding method depends on the value of the iam_method variable (POLICY|BINDINGS|MEMBERS)
* Option 2 applies the IAM roles to the service_account specified by the service_account, the binding method depends on the value of the iam_method variable (POLICY|BINDINGS|MEMBERS)
* Option 3 applies the IAM roles to the service_account specified by the service_account using an authoritative policy binding. This replaces all other bindings
* Option 4 applies the IAM roles to the service_account specified by the service_account using authoritative bindings for each role. This replaces bindings for the specified roles
* Option 5 applies the IAM roles to the service_account specified by the service_account using an additive approach. Existing bindings are not changed  


```hcl
// Option 1 - Assign IAM bindings to the service account as part of the service account module

module "service_account" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//resources/service_account"
  account_id = "<<service_account-id>>"
  iam_method   = "POLICY"
  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
}

// Option 2 - Assign IAM bindings to the service_account as part of the iam service_account module

module "service_account_iam" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/service_account"

  service_account_id = "<<service_account-id>>"

  iam_method   = "POLICY"
  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
}

// Option 3 - Assign IAM bindings to the service_account using iam service_account policy

module "service_account_iam_policy" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/service_account/policy"

  service_account_id = "<<service_account-id>>"

  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
}

// Option 4 - Assign IAM bindings to the service_account using iam service_account bindings

module "service_account_iam_bindings" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/service_account/bindings"

  service_account_id = "<<service_account-id>>"

  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
}

// Option 5 -Assign IAM bindings to the service_account using iam service_account members

module "service_account_iam_members" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/service_account/members"

  service_account_id = "<<service_account-id>>"

  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
}
```


## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.13
- Terraform Provider for GCP plugin >=v2.0

## Inputs

| Name          | Description                                                        | Type                 | Default | Required |
|---------------|--------------------------------------------------------------------|----------------------|---------|----------|
| account_id    | The fully qualified name of the service account                    | `string`             | n/a     | yes      |
| iam_method    | Method to apply IAM bindings to resources                          | `string`             | n/a     | no       |
| iam_bindings  | A map of members and roles to apply to the service account         | `map(list(string))`  | n/a     | no       |

## Outputs

