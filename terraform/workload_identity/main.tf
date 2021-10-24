# resource "google_service_account" "workload-identity-user-sa" {
#   account_id   = "workload-identity-tutorial"
#   display_name = "Service Account For Workload Identity"
# }
# resource "google_project_iam_member" "storage-role" {
#   role = "roles/storage.admin" 
#   # role   = "roles/storage.objectAdmin" 
#   member = "serviceAccount:${google_service_account.workload-identity-user-sa.email}"
# }
provider "google" {
  project = "cap-dev-sandbox-bb7d"
}

resource "google_project_iam_member" "workload_identity-role" {
  role   = "roles/iam.workloadIdentityUser"
  member = "serviceAccount:cap-dev-sandbox-bb7d.svc.id.goog[jenkins/test-ruban-sa]"
}

resource "google_project_iam_member" "workload_identity-role1" {
  role   = "roles/iam.workloadIdentityUser"
  member = "serviceAccount:cap-dev-sandbox-bb7d.svc.id.goog[jenkins/ksa-jenkins]"
}

# # create K8 resources
# cat <<EOF | kubectl apply -f -
# apiVersion: v1
# kind: Namespace
# metadata:
#   name: jenkins
# ---
# apiVersion: v1
# kind: ServiceAccount
# metadata:
#   annotations:
#     iam.gke.io/gcp-service-account: jenkins-sa@cap-dev-sandbox-bb7d.iam.gserviceaccount.com
#   name: test-ruban-sa
#   namespace: jenkins
# EOF

# # won't work
# kubectl run --rm -it test --image gcr.io/cloud-builders/gsutil ls

# # will work
# kubectl run -n jenkins --rm --serviceaccount=jenkins-sa -it test --image gcr.io/cloud-builders/gsutil ls
