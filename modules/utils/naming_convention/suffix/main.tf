resource "random_string" "suffix" {
  length  = 4
  special = false
}

locals {
  id = random_string.suffix.id
}