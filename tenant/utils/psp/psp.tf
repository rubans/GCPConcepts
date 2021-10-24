variable "applications" {
  description = "App to add to cluster"
  type        = map(string)
  default     = {}
}

variable "service_account_id" {
  description = "Service account"
  type        = string
  default     = ""
}


resource "kubernetes_pod_security_policy" "psp" {
  for_each = var.applications

  metadata {
    name = "${each.key}-psp"
  }
  spec {
    privileged                 = false
    allow_privilege_escalation = false

    volumes = [
      "*",
    ]

    run_as_user {
      rule = "RunAsAny"
    }

    se_linux {
      rule = "RunAsAny"
    }

    supplemental_groups {
      rule = "RunAsAny"
    }

    fs_group {
      rule = "RunAsAny"
    }
  }
}


resource "kubernetes_cluster_role" "cluster-role" {
  for_each = var.applications
  metadata {
    name = "${each.key}-clusterrole"
  }

  rule {
    api_groups = ["policy"]
    resources = ["podsecuritypolicies"]
    resource_names = [lookup(kubernetes_pod_security_policy.psp, "${each.key}").metadata[0].name]
    verbs      = ["use"]
  }
}


resource "kubernetes_role_binding" "role-binding" {
  for_each = var.applications
  metadata {
    name      = "${each.key}-role-binding"
    namespace = "${each.value}"  #kubernetes_namespace.jenkins-namespace.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = lookup(kubernetes_cluster_role.cluster-role, "${each.key}").metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      =  "ksa-${each.key}" # TODO correct with ksa
    namespace = each.value
  }

}
