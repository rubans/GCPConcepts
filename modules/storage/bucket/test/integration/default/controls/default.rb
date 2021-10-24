
bucket_name = input('resource_name')

control "default" do
  title "default"

  describe google_storage_bucket(name: bucket_name) do
    it { should exist }
    its('location') { should cmp 'europe-west2'.upcase }
    its('storage_class') { should eq "STANDARD" }

  end

  # describe command("gsutil bucketpolicyonly get gs://#{attribute("name")}") do
  #   its(:exit_status) { should eq 0 }
  #   its(:stderr) { should eq "" }
  #   its(:stdout) { should include "Enabled: True" }
  # end

end