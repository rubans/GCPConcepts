
instance_name = input('resource_name')
gcp_project_id = input("gcp_project_id")

control "default" do
    title "default"
  puts instance_name
  puts gcp_project_id

  describe google_compute_instance(project: gcp_project_id, zone: "europe-west2-a", name: instance_name) do
    it { should exist }
    its('status') { should eq 'RUNNING' }
    its('machine_type') { should match 'f1-micro' }
    its('scheduling.preemptible') { should match false}

    its('disks.first.boot') { should match true}

    # its('service_account_scopes') { should include 'https://www.googleapis.com/auth/cloud-platform' }


  
  end

  describe google_compute_disk(project: gcp_project_id, name: instance_name, zone: "europe-west2-a") do
    it { should exist }
    its('source_image') { should match "rhel-7-v20210817" }
  end

end