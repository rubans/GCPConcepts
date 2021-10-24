# Google module for PubSub

This module allows simple management of Google's pubsub resources including topic & subscriptions

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.13
- Terraform Provider for GCP plugin >=v2.13

## Example

Basic usage of this module is as follows:

```hcl
module "pubsub" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//pubsub"

  topic   = "<<topic-name>>"
  project = "<<proj-id>>"

  pull_subscriptions = [
    {
      name                 = "pull"
      ack_deadline_seconds = 10
    },
  ]

  push_subscriptions = [
    {
      name                 = "push"
      push_endpoint        = "https://testing-pubsub-module.appspot.com/"
      x-goog-version       = "v1beta1"
      ack_deadline_seconds = 20
      expiration_policy    = "1104800s" // one week
    },
  ]

  iam_method   = "MEMBERS"

  topic_iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }

  sub_iam_pull_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }

  sub_iam_push_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
  
}

```

## Inputs

| Name                   | Description                                                | Type                | Default | Required |
|------------------------|------------------------------------------------------------|---------------------|---------|----------|
| topic                  | The name of the pubsub topic to be created                 | `string`            | n/a     | yes      |
| project_id             | The project where pubsub resource will be created          | `any`               | n/a     | yes      |
| push_subscriptions     | The name of the pubsub push subscriptions to be created    | `list(map(string))` | n/a     | no       |
| pull_subscriptions     | The name of the pubsub pull subscriptions to be created    | `list(map(string))` | n/a     | no       |
| topic_labels           | A map of labels to assign to the Pub/Sub topic             | `map(string)`       | n/a     | no       |
| subscription_labels    | A map of labels to assign to the Pub/Sub subscriptions     | `map(string)`       | n/a     | no       |
| topic_kms_key_name     | Cloud KMS CryptoKey to be used to encrypt pubsub messages  | `string`            | n/a     | no       |
| message_storage_policy | A map of storage policies                                  | `map(any)`          | n/a     | no       |
| iam_method             | Method to apply IAM bindings to resources                  | `string`            | n/a     | no       |
| topic_iam_bindings     | A map of members and roles to apply to pubsub topic        | `map(list(string))` | n/a     | no       |
| sub_iam_pull_bindings  | A map of members and roles to apply to pull subscriptions  | `map(list(string))` | n/a     | no       |
| sub_iam_push_bindings  | A map of members and roles to apply to push subscriptions  | `map(list(string))` | n/a     | no       |


## Outputs

| Name       | Description |
|------------|-------------|
