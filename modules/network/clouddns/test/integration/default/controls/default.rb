
instance_name = input("resource_name")
gcp_project_id = input("gcp_project_id")

control "default" do
    title "default"
  puts instance_name
  puts gcp_project_id
  
  describe google_dns_managed_zone(project: gcp_project_id, zone: instance_name) do
    it { should exist }
  
  end
end