/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "random_id" "suffix" {
  byte_length = 2
}

locals {
  resource_abbr = "pst" # PubSub Topic
  name          = lower("${var.prefix}-${var.project}-${var.env}-${var.description}-${local.resource_abbr}-${random_id.suffix.hex}")
  default_labels = {
    prefix             = var.prefix
    project            = var.project
    env                = var.env
    description        = var.description
    dataclassification = var.data_classification
  }
  labels = merge(local.default_labels, var.labels)
}
locals {
  default_ack_deadline_seconds = 10
}

// Storage default service account needed for pubsub encryption (sometimes?)
data "google_storage_project_service_account" "storage_sa" {
  project = var.project
}

#--------------#
# Pubsub topic #
#--------------#
resource "google_pubsub_topic" "topic" {
  project      = var.project
  name         = local.name
  labels       = local.labels
  kms_key_name = var.kms_key_name

  dynamic "message_storage_policy" {
    for_each = var.message_storage_policy
    content {
      allowed_persistence_regions = message_storage_policy.key == "allowed_persistence_regions" ? message_storage_policy.value : null
    }
  }
}

#--------------------------#
# Pubsub push subscription #
#--------------------------#
resource "google_pubsub_subscription" "push_subscriptions" {

  for_each = { for i in var.push_subscriptions : i.name => i }

  name    = each.value.name
  topic   = google_pubsub_topic.topic.name
  project = var.project
  labels  = var.subscription_labels
  ack_deadline_seconds = lookup(
    each.value,
    "ack_deadline_seconds",
    local.default_ack_deadline_seconds,
  )
  message_retention_duration = lookup(
    each.value,
    "message_retention_duration",
    null,
  )
  retain_acked_messages = lookup(
    each.value,
    "retain_acked_messages",
    null,
  )
  filter = lookup(
    each.value,
    "filter",
    null,
  )
  enable_message_ordering = lookup(
    each.value,
    "enable_message_ordering",
    null,
  )
  dynamic "expiration_policy" {
    // check if the 'expiration_policy' key exists, if yes, return a list containing it.
    for_each = contains(keys(each.value), "expiration_policy") ? [each.value.expiration_policy] : []
    content {
      ttl = expiration_policy.value
    }
  }

  dynamic "dead_letter_policy" {
    for_each = (lookup(each.value, "dead_letter_topic", "") != "") ? [each.value.dead_letter_topic] : []
    content {
      dead_letter_topic     = lookup(each.value, "dead_letter_topic", "")
      max_delivery_attempts = lookup(each.value, "max_delivery_attempts", "5")
    }
  }

  dynamic "retry_policy" {
    for_each = (lookup(each.value, "maximum_backoff", "") != "") ? [each.value.maximum_backoff] : []
    content {
      maximum_backoff = lookup(each.value, "maximum_backoff", "")
      minimum_backoff = lookup(each.value, "minimum_backoff", "")
    }
  }

  push_config {
    push_endpoint = each.value["push_endpoint"]
  }
  depends_on = [
    google_pubsub_topic.topic,
  ]
}

#--------------------------#
# Pubsub pull subscription #
#--------------------------#
resource "google_pubsub_subscription" "pull_subscriptions" {
  for_each = { for i in var.pull_subscriptions : i.name => i }

  name    = each.value.name
  topic   = google_pubsub_topic.topic.name
  project = var.project
  labels  = var.subscription_labels
  ack_deadline_seconds = lookup(
    each.value,
    "ack_deadline_seconds",
    local.default_ack_deadline_seconds,
  )
  message_retention_duration = lookup(
    each.value,
    "message_retention_duration",
    null,
  )
  retain_acked_messages = lookup(
    each.value,
    "retain_acked_messages",
    null,
  )
  filter = lookup(
    each.value,
    "filter",
    null,
  )
  enable_message_ordering = lookup(
    each.value,
    "enable_message_ordering",
    null,
  )
  dynamic "expiration_policy" {
    // check if the 'expiration_policy' key exists, if yes, return a list containing it.
    for_each = contains(keys(each.value), "expiration_policy") ? [each.value.expiration_policy] : []
    content {
      ttl = expiration_policy.value
    }
  }

  dynamic "dead_letter_policy" {
    for_each = (lookup(each.value, "dead_letter_topic", "") != "") ? [each.value.dead_letter_topic] : []
    content {
      dead_letter_topic     = lookup(each.value, "dead_letter_topic", "")
      max_delivery_attempts = lookup(each.value, "max_delivery_attempts", "5")
    }
  }

  dynamic "retry_policy" {
    for_each = (lookup(each.value, "maximum_backoff", "") != "") ? [each.value.maximum_backoff] : []
    content {
      maximum_backoff = lookup(each.value, "maximum_backoff", "")
      minimum_backoff = lookup(each.value, "minimum_backoff", "")
    }
  }

  depends_on = [
    google_pubsub_topic.topic,
  ]
}

/***********************************************
  Assign iam roles to the pubsub topic
 ***********************************************/
module pubsub_topic_iam {
  source = "../../iam/resource/pubsub/topic"

  topic   = google_pubsub_topic.topic.name
  project = var.project

  iam_method   = var.iam_method
  iam_bindings = var.topic_iam_bindings
}


/**************************************************
  Assign iam roles to the pubsub pull subscriptions
 *************************************************/
module pubsub_sub_pull_iam {
  source = "../../iam/resource/pubsub/sub"

  for_each =  { for i in var.pull_subscriptions : i.name => i }

  project      = var.project
  subscription_name = each.value.name
  
  iam_method   = var.iam_method
  iam_bindings = var.sub_iam_pull_bindings
}


/**************************************************
  Assign iam roles to the pubsub push subscriptions
 *************************************************/
module pubsub_sub_push_iam {
  source = "../../iam/resource/pubsub/sub"

  for_each =  { for i in var.push_subscriptions : i.name => i }

  project      = var.project
  subscription_name = each.value.name
  
  iam_method   = var.iam_method
  iam_bindings = var.sub_iam_push_bindings
}
