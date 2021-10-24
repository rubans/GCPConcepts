output "key" {
  description = "The full key resource."
  value       = google_kms_crypto_key.key
}

output "location" {
  description = "The location of the keyring"
  value       = google_kms_key_ring.keyring.location
}

