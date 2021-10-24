# GCP PubSub Topic Identity and Access Management

These modules are helper modules to create IAM bindings between resources, roles and members. These modules are usually used by the resource modules themselves, by passing the relevant parameters (iam_method, iam_bindings and audit_configs), or directly by passing these same parameters and the resource identifier. 

There are three different ways in which IAM bindings can be applied to resources:
* policy  - creates a policy and assigns to a resource, completely replacing any previous bindings (authoritative at resource level)
* bindings - creates bindings and assigns them to a resource, replacing previous bindings (authoritative at role level)
* members  - creates individual bindings and assigns them to a resource, does not replace any previous bindings (additive)
## Usage

The following examples show how to assign IAM bindings to the topic.
* Option 1 applies the IAM roles to the topic in the resource module, the binding method depends on the value of the iam_method variable (POLICY|BINDINGS|MEMBERS)
* Option 2 applies the IAM roles to the topic specified by the topic name, the binding method depends on the value of the iam_method variable (POLICY|BINDINGS|MEMBERS)
* Option 3 applies the IAM roles to the topic specified by the topic name using an authoritative policy binding. This replaces all other bindings
* Option 4 applies the IAM roles to the topic specified by the topic name using authoritative bindings for each role. This replaces bindings for the specified roles
* Option 5 applies the IAM roles to the topic specified by the topic name using an additive approach. Existing bindings are not changed  


```hcl
// Option 1 - Assign IAM bindings to the topic as part of the pubsub module

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

// Option 2 - Assign IAM bindings to the topic as part of the iam topic module

module "topic_iam" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/resource/pubsub/topic"

  topic   = "<<topic-name>>"
  project = "<<proj-id>>"


  iam_method   = "POLICY"
  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
}

// Option 3 - Assign IAM bindings to the topic using iam topic policy

module "topic_iam_policy" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/resource/pubsub/topic/policy"

  topic   = "<<topic-name>>"
  project = "<<proj-id>>"


  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
}

// Option 4 - Assign IAM bindings to the topic using iam topic bindings

module "topic_iam_bindings" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/resource/pubsub/topic/bindings"

  topic   = "<<topic-name>>"
  project = "<<proj-id>>"

  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }
}

// Option 5 -Assign IAM bindings to the topic using iam topic members

module "topic_iam_members" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/resource/pubsub/topic/members"

  topic   = "<<topic-name>>"
  project = "<<proj-id>>"

  iam_bindings = {
    "user:admin@gcp-foundation.com" = [ "owner", "editor" ]
    "group:gcp-organization-admins@gcp-foundation.com" = [ "owner", "editor" ]
    "serviceAccount:org-terraform@cap-seed-1234.iam.gserviceaccount.com" = [ "owner", "editor" ]
  }

}
```
## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.13
- Terraform Provider for GCP plugin >=v3.30

## Inputs

| Name          | Description                                                        | Type                 | Default | Required |
|---------------|--------------------------------------------------------------------|----------------------|---------|----------|
| project_id    | The ID of the project where pubsub topic will be created           | `string`             | n/a     | yes       |
| topic         | The name of the pubsub topic                                       | `string`             | n/a     | yes      |
| iam_method    | Method to apply IAM bindings to resources                          | `string`             | MEMBER  | no       |
| iam_bindings  | A map of members and roles to apply to the service account         | `map(list(string))`  | n/a     | no       |

## Outputs

