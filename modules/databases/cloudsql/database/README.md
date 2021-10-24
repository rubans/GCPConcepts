# Google Cloud SQL Database

This module makes it easy to create Google CloudSQL instance and implement high availability settings.

## Usage

Basic usage of this module is as follows:

```hcl
module "gcp_database" {
  source  = "git::ssh://git@github.com/ps-gcp-foundation/modules//cloudsql/database"
  
  database_name = "db-name"
  network = "vpc-network"
  instance_name = "instance-name"
  project  = "project"
  region = "region"
}
```

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0

## Inputs

| Name                  | Description                                                   | Type     | Default          | Required |
|-----------------------|---------------------------------------------------------------|----------|------------------|---------|
| classification        | Classification of database                                    | `string` | `"confidential"` | no       |
| database\_name        | Name of the database to create in the instance                | `string` | n/a              | yes      |
| encryption\_key\_name | Encryption key name if using customer managed encryption keys | `string` | `null`           | no       |
| instance\_name        | The name of the database instance                             | `string` | n/a              | yes      |
| network               | The VPC network to create the database in                     | `any`    | n/a              | yes      |
| owner                 | Database Owner                                                | `string` | `""`             | no       |
| password              | Password for the user                                         | `string` | `"admin"`        | no       |
| project               | The project to create the database in                         | `any`    | n/a              | yes      |
| region                | The region to create the database in                          | `string` | n/a              | yes      |
| user                  | Name of the database user to create                           | `string` | `"admin"`        | no       |

## Outputs

No output.

