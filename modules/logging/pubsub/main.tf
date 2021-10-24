locals {
  data_classifications = {
    "DEFAULT" = "confidential",
    "AUDIT"   = "highlyconfidential"
  }
  destination_uri = "pubsub.googleapis.com/projects/${var.project}/topics/${module.pubsub.topic}"
}

module "pubsub" {
  source = "../../bigdata/pubsub"

  prefix              = var.prefix
  project             = var.project
  env                 = var.env
  description         = var.description
  data_classification = lookup(local.data_classifications, var.log_type, "confidential")
  kms_key_name        = var.key_name

  message_storage_policy = {
    allowed_persistence_regions = var.allowed_persistence_regions
  }

  labels = var.labels
}

resource "google_pubsub_topic_iam_member" "pubsub_sink_member" {
  project = var.project
  topic   = module.pubsub.topic
  role    = "roles/pubsub.publisher"
  member  = var.log_sink_writer_identity
}
