# Google Logging Big Query

This module allows simple management of Google Logging Big Query

## Usage

Basic usage of this module is as follows:

```hcl
module "logging_bigquery" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//logging/bigquery"

  dataset_name  = "dataset"
  key_name      = "ds-key"
  project_id    = "Project"
  log_sink_writer_identity = "id"

}
```

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0

## Inputs

| Name                           | Description                                                                                                                                                       | Type     | Default                | Required |
|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|------------------------|----------|
| dataset\_name                  | The name of the bigquery dataset to be created and used for log entries matching the filter.                                                                      | `string` | n/a                    | yes      |
| expiration\_days               | Table expiration time. If unset logs will never be deleted.                                                                                                       | `number` | `"null"`               | no       |
| delete\_contents\_on\_destroy  | (Optional) If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present. | `bool`   | `true`                 | no       |
| description                    | A use-friendly description of the dataset                                                                                                                         | `string` | `"Log export dataset"` | no       |
| key\_name                      | Key name                                                                                                                                                          | `string` | n/a                    | yes      |
| location                       | The location of the storage bucket.                                                                                                                               | `string` | `"US"`                 | no       |
| log\_sink\_writer\_identity    | The service account that logging uses to write log entries to the destination. (This is available as an output coming from the root module).                      | `string` | n/a                    | yes      |
| project\_id                    | The ID of the project in which the bigquery dataset will be created.                                                                                              | `string` | n/a                    | yes      |

## Outputs

| Name             | Description                                             |
|------------------|---------------------------------------------------------|
| console\_link    | The console link to the destination bigquery dataset    |
| dataset\_id      | The dataset id for the destination bigquery dataset     |
| destination\_uri | The destination URI for the bigquery dataset.           |
| project          | The project in which the bigquery dataset was created.  |
| resource\_id     | The resource id for the destination bigquery dataset    |
| resource\_name   | The resource name for the destination bigquery dataset  |
| self\_link       | The self\_link URI for the destination bigquery dataset |
