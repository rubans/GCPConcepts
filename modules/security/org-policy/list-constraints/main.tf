locals {
  organization   = var.policy_level == "organization"
  folder         = var.policy_level == "folder"
  project        = var.policy_level == "project"
  valid_policy   = !local.invalid_config
  enable         = var.enable

  allow_all_constraint  = var.allow_all_constraint == true
  invalid_config_case_1 = var.deny_list_length > 0 && var.allow_list_length > 0
  invalid_config_case_2 = var.allow_list_length + var.deny_list_length > 0 && var.enable != null
  invalid_config        = local.invalid_config_case_1 || local.invalid_config_case_2
}

/******************************************
  Organization policy, allow all
 *****************************************/
resource "google_organization_policy" "org_policy_list_allow_all" {
  count = local.enable && local.organization && local.valid_policy && local.allow_all_constraint == true ? 1 : 0

  org_id     = var.org_id
  constraint = var.constraint

  list_policy {
    allow {
      all = true
    }
  }
}

/******************************************
  Folder policy, allow all
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_list_allow_all" {
  count = local.enable && local.folder && local.valid_policy && local.allow_all_constraint == true ? 1 : 0

  folder     = var.folder_id
  constraint = var.constraint

  list_policy {
    allow {
      all = true
    }
  }
}

/******************************************
  Project policy, allow all
 *****************************************/
resource "google_project_organization_policy" "project_policy_list_allow_all" {
  count = local.enable && local.project && local.valid_policy && local.allow_all_constraint == true ? 1 : 0

  project    = var.project_id
  constraint = var.constraint

  list_policy {
    allow {
      all = true
    }
  }
}

/******************************************
  Organization policy, deny all
 *****************************************/
resource "google_organization_policy" "org_policy_list_deny_all" {
  count = local.enable && local.organization && local.valid_policy && local.allow_all_constraint == false ? 1 : 0

  org_id     = var.org_id
  constraint = var.constraint

  list_policy {
    deny {
      all = true
    }
  }
}

/******************************************
  Folder policy, deny all
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_list_deny_all" {
  count = local.enable && local.folder && local.valid_policy && local.allow_all_constraint == false ? 1 : 0

  folder     = var.folder_id
  constraint = var.constraint

  list_policy {
    deny {
      all = true
    }
  }
}

/******************************************
  Project policy, deny all
 *****************************************/
resource "google_project_organization_policy" "project_policy_list_deny_all" {
  count = local.enable && local.project && local.valid_policy && local.allow_all_constraint == false ? 1 : 0

  project    = var.project_id
  constraint = var.constraint

  list_policy {
    deny {
      all = true
    }
  }
}

/******************************************
  Organization policy, deny values
 *****************************************/
resource "google_organization_policy" "org_policy_list_deny_values" {
  count = local.enable && local.organization && local.valid_policy && var.deny_list_length > 0 ? 1 : 0

  org_id     = var.org_id
  constraint = var.constraint

  list_policy {
    deny {
      values = var.deny_list
    }
  }
}

/******************************************
  Folder policy, deny values
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_list_deny_values" {
  count = local.enable && local.folder && local.valid_policy && var.deny_list_length > 0 ? 1 : 0

  folder     = var.folder_id
  constraint = var.constraint

  list_policy {
    deny {
      values = var.deny_list
    }
  }
}

/******************************************
  Project policy, deny values
 *****************************************/
resource "google_project_organization_policy" "project_policy_list_deny_values" {
  count = local.enable && local.project && local.valid_policy && var.deny_list_length > 0 ? 1 : 0

  project    = var.project_id
  constraint = var.constraint

  list_policy {
    deny {
      values = var.deny_list
    }
  }
}

/******************************************
  Organization policy, allow values
 *****************************************/
resource "google_organization_policy" "org_policy_list_allow_values" {
  count = local.enable && local.organization && local.valid_policy && var.allow_list_length > 0 ? 1 : 0

  org_id     = var.org_id
  constraint = var.constraint

  list_policy {
    allow {
      values = var.allow_list
    }
  }
}

/******************************************
  Folder policy, allow values
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_list_allow_values" {
  count = local.enable && local.folder && local.valid_policy && var.allow_list_length > 0 ? 1 : 0

  folder     = var.folder_id
  constraint = var.constraint

  list_policy {
    allow {
      values = var.allow_list
    }
  }
}

/******************************************
  Project policy, allow values
 *****************************************/
resource "google_project_organization_policy" "project_policy_list_allow_values" {
  count = local.enable && local.project && local.valid_policy && var.allow_list_length > 0 ? 1 : 0

  project    = var.project_id
  constraint = var.constraint

  list_policy {
    allow {
      values = var.allow_list
    }
  }
}

/******************************************
  Exclude folders from policy
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_list_exclude_folders" {
  for_each = (! local.project) ? var.exclude_folders : []

  folder     = each.value
  constraint = var.constraint

  restore_policy {
    default = true
  }
}

/******************************************
  Exclude projects from policy
 *****************************************/
resource "google_project_organization_policy" "project_policy_list_exclude_projects" {
  for_each = (!local.project) ? var.exclude_projects : []

  project    = each.value
  constraint = var.constraint

  restore_policy {
    default = true
  }
}

/******************************************
  Checks a valid configuration for list constraint
 *****************************************/
resource "null_resource" "config_check" {
  /*
    This resource shows the user a message intentionally
    If user sets two (or more) of following variables when policy type is "list":
    - allow
    - deny
    - enforce ("true" or "false")
    the configuration is invalid and the message below is shown
  */
  count = local.invalid_config ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'For list constraints only one of enforce, allow, and deny may be included.'; false"
  }
}