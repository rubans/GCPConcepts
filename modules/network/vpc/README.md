# Google VPC Module

This module allows simple management of Google VPC

## Requirements

| Name      | Version         |
|-----------|-----------------|
| terraform | >=0.12.6, <0.14 |
| google    | <4.0,>= 3.0.0   |

## Providers

| Name   | Version       |
|--------|---------------|
| google | <4.0,>= 3.0.0 |

## Usage

Basic usage of this module is as follows:

```hcl
module "vpc" {
  source  = "git::ssh://git@github.com/ps-gcp-foundation/modules//network/vpc"
  project = module.project.project
  name    = "vs-app-vpc"
  shared  = true
}
```

## Inputs

| Name           | Description                      | Type     | Default | Required |
|----------------|----------------------------------|----------|---------|----------|
| name           | The name of the vpc to create    | `string` | n/a     | yes      |
| project        | The name of the project          | `any`    | n/a     | yes      |
| description    | A description of the vpc         | `string` | `null`  | no       |
| delete_routes  | Delete optional routes on create | `bool`   | `false` | no       |
| shared         | Define the vpc as a shared       | `bool`   | `false` | no       |
| mtu            | MTU in bytes                     | `integer`| `1460`  | no       |
