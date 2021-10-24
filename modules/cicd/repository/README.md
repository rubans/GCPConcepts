# Google platform for Repository

This module allows simple management of Google platform for Repository

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0

## Example

Basic usage of this module is as follows:

```hcl
module "cap-vs-app-repo" {
	source = "git::ssh://git@github.com/ps-gcp-foundation/modules//platform/repository"

	name            = "cap-vs-app-repo"
	project         = module.project.project
	service_account = module.spinnaker_service_account.account
	topic           = "cap-vs-app-repo-push"
}
```

## Inputs

| Name                | Description                                                | Type                | Default | Required |
|---------------------|------------------------------------------------------------|---------------------|---------|----------|
| iam_method          | Method to apply IAM bindings to resources                  | `string`            | n/a     | no       |
| iam_bindings        | A map of members and roles to apply to the service account | `map(list(string))` | n/a     | no       |
| module\_depends\_on | Module dependency variable                                 | `any`               | `[]`    | no       |
| name                | The repository name                                        | `string`            | n/a     | yes      |
| project             | The project that owns the repository                       | `any`               | n/a     | yes      |
| service\_account    | The service account to send pub/sub messages               | `any`               | n/a     | yes      |
| topic               | The pub/sub topic name                                     | `string`            | n/a     | yes      |

## Outputs

| Name       | Description |
|------------|-------------|
| repository | n/a         |
