# common naming convention based resource name related dependencies
module "validate_naming_conventions" {
  source                = "../../utils/naming_convention"
  prefix                = var.prefix         
  environment           = var.environment
  resource_type         = "google_compute_security_policy"
  tenant_name           = var.tenant_name
  # location_abbr = module.location.abbr
}
# cloudarmor
locals {
  environment_abbr          = module.validate_naming_conventions.environment_abbr
  suffix                    = module.validate_naming_conventions.suffix
  location_abbr             = "" # not require for this resource so defaulting
  resource_type_abbr        = module.validate_naming_conventions.resource_type_abbr
  resource_name             = lower("${var.prefix}-${var.tenant_name}-${local.environment_abbr}-${local.resource_type_abbr}${local.location_abbr != "" ? local.location_abbr : ""}-%s-${local.suffix}")
}

resource "google_compute_security_policy" "cloudarmor-security-policy" {
  project     = var.project
  for_each    = var.security_policy
  name        = format(local.resource_name,each.key)
  description = each.value.description
  dynamic "rule" {
    for_each = lookup(each.value, "versioned_expr", null)
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        versioned_expr = rule.value.versioned_expr_name
        config {
          src_ip_ranges = flatten(rule.value.src_ip_ranges)
        }
      }
      description = rule.value.rule_description
    }
  }
  dynamic "rule" {
    for_each = lookup(each.value, "expr", null)
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        expr {
          expression = rule.value.expression
        }
      }
      description = rule.value.rule_description
      preview     = (length(rule.value) == 4 ? false : rule.value.preview)
    }
  }
}