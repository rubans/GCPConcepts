
instance_name = input('resource_name')
gcp_project_id = input("gcp_project_id")
location = input("resource_location")

control "default" do
    title "default"
  puts instance_name
  puts gcp_project_id
  puts location

  describe google_container_cluster(project: gcp_project_id, location: location, name: instance_name) do
    it { should exist }
    its('status') { should eq 'RUNNING' }

    # its('service_account_scopes') { should include 'https://www.googleapis.com/auth/cloud-platform' }


  
  end
end