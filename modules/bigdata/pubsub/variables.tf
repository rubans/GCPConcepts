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

variable "prefix" {
  description = "The string used to prefix resources within this folder. Considered to be the cost owner of all resources in said folder."
  type        = string
}

variable "project" {
  description = "The ID of the project in which the resource will be created. Considered the owner of the resources."
  type        = string
}

variable "env" {
  description = "The environment the resource is in"
  type        = string
}

variable "description" {
  description = "What the resource is for. Backend, frontend, etc"
  type        = string
}

variable "data_classification" {
  description = "What the data should be classified as"
  type        = string
  default     = "confidential"
}

variable "labels" {
  description = "Labels (in addition to the defaults)"
  type        = map(string)
  default     = {}
}

variable "push_subscriptions" {
  type        = list(map(string))
  description = "The list of the push subscriptions"
  default     = []
}

variable "pull_subscriptions" {
  type        = list(map(string))
  description = "The list of the pull subscriptions"
  default     = []
}

variable "subscription_labels" {
  type        = map(string)
  description = "A map of labels to assign to every Pub/Sub subscription"
  default     = {}
}

variable "message_storage_policy" {
  type        = map(any)
  description = "A map of storage policies. Default - inherit from organization's Resource Location Restriction policy."
  default     = {}
}

variable "kms_key_name" {
  type        = string
  description = "The resource name of the Cloud KMS CryptoKey to be used to protect access to messages published on this topic."
  default     = null
}

variable "iam_method" {
  type        = string
  description = "IAM Binding method MEMBER|BINDING|POLICY"
  default     = "MEMBER"
}

variable "topic_iam_bindings" {
  description = "Topic: Map of members with a list of roles for each member"
  type        = map(list(string))
  default     = {}
}

variable "sub_iam_pull_bindings" {
  description = "Pull bindings: Map of members with a list of roles for each member"
  type        = map(list(string))
  default     = {}
}

variable "sub_iam_push_bindings" {
  description = "Push bindings: Map of members with a list of roles for each member"
  type        = map(list(string))
  default     = {}
}
