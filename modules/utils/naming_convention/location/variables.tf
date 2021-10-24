variable "location" {
  description = "The location"
  type        = string
  validation {
    condition = (
      contains(["asia", "asia-east1", "asia-east2", "asia-northeast1", "asia-northeast2", "asia-northeast3", "asia-south1",
               "asia-south2", "asia-southeast1", "asia-southeast2", "asia1", "australia-southeast1", "australia-southeast2",
               "eur3", "eur4", "eur5", "europe", "europe-central2", "europe-north1", "europe-west1", "europe-west2", 
               "europe-west3", "europe-west4", "europe-west6", "global", "nam3", "nam4", "nam6", "nam9",
               "northamerica-northeast1", "northamerica-northeast2", "southamerica-east1", "us", "us-central1",
               "us-east1", "us-east4", "us-west1", "us-west2", "us-west3", "us-west4"], var.location) == true
      )
      error_message = "The location must match one of the above values."
  }
}