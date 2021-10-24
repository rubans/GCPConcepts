# Resource project

This module enables creation of a project and enable service APIs for it. It allows project to be created as a host or a service project. This module deprevilages default service account and creates a new service account for the project. It also allows iam bindings to be created for the project based on iam method provided in input.


## Usage

Basic usage of this module is as follows:

```hcl

module "project" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//resources/project"
  name            = "<<proj-name>>"
  folder_id       = "<<folder-id>>"
  billing_account = "<<billing-account>>"
  iam_method   = "POLICY"
  iam_bindings  = { group : "gcp-organization-admins@example.com", roles : var.group_roles["gcp-organization-admins"] }
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

| Name           | Description                              | Type          | Default | Required |
|----------------|------------------------------------------|---------------------|---------|----------|
| name           | The name of the project                  | `string`            | n/a     | yes      |
| folder_id      | The folder to create project under       | `string`            | n/a     | yes      |
| billing_account| The billing account linked to the project| `string`            | n/a     | yes      |
| iam_method    | Method to apply IAM bindings to resources | `string     `       | MEMBER  | no       |
| iam_bindings  | Set of IAM bindings to apply              | `map(list(string))` | null    | no       |
| audit_configs | Management of audit config for the project| `map(list(string))` | null    | no       |


## Outputs

| Name                  | Description                                           |
|-----------------------|-------------------------------------------------------|
| project               | The project object                                    |
| services              | The services enabled for the project                  |

