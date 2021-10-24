output "allow_ingress_name" {
  description = "List of all allow ingress rule resource names."
  value = tomap({
    for k, v in google_compute_firewall.allow_ingress : k => v.name
  })
}

output "deny_ingress_name" {
  description = "List of all deny ingress rule resource names."
  value = tomap({
    for k, v in google_compute_firewall.deny_ingress : k => v.name
  })
}

output "allow_egress_name" {
  description = "List of all allow egress rule resource names."
  value = tomap({
    for k, v in google_compute_firewall.allow_egress : k => v.name
  })
}

output "deny_egress_name" {
  description = "List of all deny egress rule resource names."
  value = tomap({
    for k, v in google_compute_firewall.deny_egress : k => v.name
  })
}
