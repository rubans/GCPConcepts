output "generated" {
  description = "The random generated sufix hex"
  value       = lower(substr(local.id,0,4))
}
