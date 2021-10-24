output "abbr" {
  description = "The abbreviation of the environment"
  value       = substr(var.environment,0,1)
}
