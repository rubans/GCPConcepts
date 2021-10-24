instance_name = input('resource_name')
gcp_project_id = input("gcp_project_id")
instance_region = input("region")

control "default" do
  title "default"
  puts instance_name
  puts gcp_project_id

  describe google_compute_subnetwork(project: gcp_project_id, region: instance_region, name: instance_name) do
    it { should exist }
    its('ip_cidr_range') { should eq '10.0.0.0/23' }
    its('name') { should eq instance_name}

    its('private_ip_google_access') { should be false}

    its('log_config.enable') { should be true }

    its('log_config.aggregation_interval') { should cmp 'INTERVAL_1_MIN' }
    its('log_config.metadata') { should include 'CUSTOM_METADATA' }

#     puts "-x-x-x-x-"
#     puts its('secondary_ip_ranges')
#
#     its('secondary_ip_ranges').each do |n|
#       puts n
#     end

  end
end
