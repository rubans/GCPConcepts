# Resource folder

This module enables the creation and management of a Google Cloud folder. To create a folder requires either an orgnisation or another folder as the parent, 

A folder can contain projects, other folders, or a combination of both. You can use folders to group projects under an organization in a hierarchy. For example, your organization might contain multiple departments, each with its own set of Cloud Platform resources. Folders allows you to group these resources on a per-department basis. Folders are used to group resources that share common IAM policies.

## Usage

The following example shows how to import an organisation and create folders within this organisation.

```hcl
module "organization" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//resource/organization"

  domain = "example.com"

  groups = [
    { group : "gcp-folder-admins@example.com", roles : ["resourcemanager.folderAdmin"]] }
  ]
}

module "folder_level_1" {
  source  = "git::ssh://git@github.com/ps-gcp-foundation/modules//resource/folder"
  
  name   = "folder-level-1"
  parent = module.organization.organization.id

  iam_method    = "POLICY|BINDINGS|MEMBERS"
  iam_bindings  = { group : "gcp-folder-admins@example.com", roles : ["resourcemanager.folderAdmin"]] }
  audit_configs = {
    "allServices" = ["ADMIN_READ", "DATA_READ", "DATA_WRITE"]
  }
}

module "folder_level_2" {
  source  = "git::ssh://git@github.com/ps-gcp-foundation/modules//resource/folder"
  
  name   = "folder-level-2"
  parent = module.folder_level_1.folder.id

  iam_method    = "POLICY|BINDINGS|MEMBERS"
  iam_bindings  = { group : "gcp-folder-admins@example.com", roles : ["resourcemanager.folderAdmin"]] }
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
| name          | The name of the folder                   | `string`            | n/a     | yes      |
| parent        | The id of the organisation or folder     | `string`            | n/a     | yes      |
| iam_method    | Method to apply IAM bindings to resources| `string     `       | MEMBER  | no       |
| iam_bindings  | Set of IAM bindings to apply             | `map(list(string))` | null    | no       |
| audit_configs | Management of audit config for a folder  | `map(list(string))` | null    | no       |


## Outputs

| Name   | Description                          |               |
|--------|--------------------------------------|---------------|
| folder | The folder object                    |               |        

