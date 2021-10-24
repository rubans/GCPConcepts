# Google platform for Build

This module allows simple management of Google platform for Build.

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0

## Inputs

| Name                | Description                                       | Type          | Default             | Required |
|---------------------|---------------------------------------------------|---------------|---------------------|----------|
| branch              | The name of the branch of the repository to build | `string`      | n/a                 | yes      |
| filename            | The name of the cloud build definition file       | `string`      | `"cloudbuild.yaml"` | no       |
| module\_depends\_on | Module dependency variable                        | `any`         | `[]`                | no       |
| name                | The name of the cloud build trigger               | `string`      | n/a                 | yes      |
| project             | The project                                       | `any`         | n/a                 | yes      |
| repository          | The name of the repository to build               | `any`         | n/a                 | yes      |
| substitutions       | Substitutions to be made when building            | `map(string)` | `null`              | no       |

## Outputs

No output.

