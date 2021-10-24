project = "cap-dev-sandbox-bb7d"
region = "europe-west2"
name = "gke-cluster"
kms_key_name = "projects/cap-dev-sandbox-bb7d/locations/europe-west2/keyRings/mgmt/cryptoKeys/gke"
maintenance_policy = {
    start_time = "2021-05-14T19:00:00Z"
    end_time = "2021-05-16T19:00:00Z"
    recurrence = "FREQ=WEEKLY;BYDAY=FR"
}
network = "gke-network"
subnetwork = "gke-subnet"
service_account = "sbox-terraform@cap-dev-sandbox-bb7d.iam.gserviceaccount.com"
private_cluster = false
workload_identity_user = "jenkins-sa"
workload_identity_namespace = "jenkins"