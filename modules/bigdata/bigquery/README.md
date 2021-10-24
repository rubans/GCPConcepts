# Google BigQuery

This module allows you to create opinionated Google Cloud Platform BigQuery datasets and tables. This will allow the user to programmatically create an empty table schema inside of a dataset, ready for loading. Additional user accounts and permissions are necessary to begin querying the newly created table(s).

## Usage

Basic usage of this module is as follows:

```hcl
module "bigquery" {
  source  = "git::ssh://git@github.com/ps-gcp-foundation/modules//bigquery"

  dataset_id                  = "foo"
  dataset_name                = "foo"
  description                 = "some description"
  project_id                  = "<PROJECT ID>"
  location                    = "US"
  default_table_expiration_ms = 3600000

  tables = [
  {
    table_id          = "foo",
    schema            =  "<PATH TO THE SCHEMA JSON FILE>",
    time_partitioning = {
      type                     = "DAY",
      field                    = null,
      require_partition_filter = false,
      expiration_ms            = null,
    },
    expiration_time = null,
    clustering      = ["fullVisitorId", "visitId"],
    labels          = {
      env      = "dev"
      billable = "true"
      owner    = "joedoe"
    },
  }
  ],

  views = [
    {
      view_id    = "barview",
      use_legacy_sql = false,
      query          = <<EOF
      SELECT
       column_a,
       column_b,
      FROM
        `project_id.dataset_id.table_id`
      WHERE
        approved_user = SESSION_USER
      EOF,
      labels = {
        env      = "devops"
        billable = "true"
        owner    = "joedoe"
      }
    }
  ]
  dataset_labels = {
    env      = "dev"
    billable = "true"
  }
}
```

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0


## Inputs
| Name                           | Description                                                                                                                                                       | Type                                                                                                                                                                                                                                                                                                                                                                                                                            | Default                                                                                                            | Required |
|--------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------|----------|
| access                         | An array of objects that define dataset access for one or more entities.                                                                                          | `any`                                                                                                                                                                                                                                                                                                                                                                                                                           | <pre>[<br>  {<br>    "role": "roles/bigquery.dataOwner",<br>    "special_group": "projectOwners"<br>  }<br>]</pre> | no       |
| dataset\_id                    | Unique ID for the dataset being provisioned.                                                                                                                      | `string`                                                                                                                                                                                                                                                                                                                                                                                                                        | n/a                                                                                                                | yes      |
| dataset\_labels                | Key value pairs in a map for dataset labels                                                                                                                       | `map(string)`                                                                                                                                                                                                                                                                                                                                                                                                                   | `{}`                                                                                                               | no       |
| dataset\_name                  | Friendly name for the dataset being provisioned.                                                                                                                  | `string`                                                                                                                                                                                                                                                                                                                                                                                                                        | `null`                                                                                                             | no       |
| default\_table\_expiration\_ms | TTL of tables using the dataset in MS                                                                                                                             | `number`                                                                                                                                                                                                                                                                                                                                                                                                                        | `null`                                                                                                             | no       |
| delete\_contents\_on\_destroy  | (Optional) If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present. | `bool`                                                                                                                                                                                                                                                                                                                                                                                                                          | `null`                                                                                                             | no       |
| description                    | Dataset description.                                                                                                                                              | `string`                                                                                                                                                                                                                                                                                                                                                                                                                        | `null`                                                                                                             | no       |
| location                       | The regional location for the dataset only US and EU are allowed in module                                                                                        | `string`                                                                                                                                                                                                                                                                                                                                                                                                                        | `"US"`                                                                                                             | no       |
| project\_id                    | Project where the dataset and table are created                                                                                                                   | `string`                                                                                                                                                                                                                                                                                                                                                                                                                        | n/a                                                                                                                | yes      |
| tables                         | A list of objects which include table\_id, schema, clustering, time\_partitioning, expiration\_time and labels.                                                   | <pre>list(object({<br>    table_id   = string,<br>    schema     = string,<br>    clustering = list(string),<br>    time_partitioning = object({<br>      expiration_ms            = string,<br>      field                    = string,<br>      type                     = string,<br>      require_partition_filter = bool,<br>    }),<br>    expiration_time = string,<br>    labels          = map(string),<br>  }))</pre> | `[]`                                                                                                               | no       |
| views                          | A list of objects which include table\_id, which is view id, and view query                                                                                       | <pre>list(object({<br>    view_id        = string,<br>    query          = string,<br>    use_legacy_sql = bool,<br>    labels         = map(string),<br>  }))</pre>                                                                                                                                                                                                                                                            | `[]`                                                                                                               | no       |

## Outputs

| Name              | Description                                        |
|-------------------|----------------------------------------------------|
| bigquery\_dataset | Bigquery dataset resource.                         |
| bigquery\_tables  | Map of bigquery table resources being provisioned. |
| bigquery\_views   | Map of bigquery view resources being provisioned.  |
| project           | Project where the dataset and tables are created   |
| table\_ids        | Unique id for the table being provisioned          |
| table\_names      | Friendly name for the table being provisioned      |
| view\_ids         | Unique id for the view being provisioned           |
| view\_names       | friendlyname for the view being provisioned        |
