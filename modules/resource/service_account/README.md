# Resource service account 

This module enables creation of a service account resource. It also allows iam bindings to be created for the service account based on iam method provided in input.


## Usage

Basic usage of this module is as follows:

```hcl
module "service_account" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//resources/service_account"
  service_account = "<<service_account-id>>"
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
```

## Requirements

To use this module

### Software

The following dependencies must be available:

- Terraform >=v0.13
- Terraform Provider for GCP plugin >=v2.0

## Inputs


| Name          | Description                              | Type                | Default | Required |
|---------------|------------------------------------------|---------------------|---------|----------|
| account_id    | The name of the service account          | `string`            | n/a     | yes      |
| display_name  | Display name for the service account     | `string`            | n/a     | no       |
| description   | A description of the service account     | `string`            | n/a     | no       |
| project       | The project to create the service account| `string`            | n/a     | no       |
| iam_method    | Method to apply IAM bindings to resources| `string`            | MEMBER  | no       |
| iam_bindings  | Set of IAM bindings to apply             | `map(list(string))` | null    | no       |

## Outputs

| Name                  | Description                                           |
|-----------------------|-------------------------------------------------------|
| account               | The service account object                            |
| keys                  | Service Account keys                                  |

