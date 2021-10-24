default_deny_ingress = input('default_deny_ingress')
test1_allow_ingress = input('test1_allow_ingress')
gcp_project_id = input("gcp_project_id")

control "default" do
  title "default"
  puts default_deny_ingress
  puts gcp_project_id

  describe google_compute_firewall(project: gcp_project_id, name: default_deny_ingress) do
    it { should exist }
    its('direction') { should eq 'INGRESS' }
  end
end

control "test1" do
  title "test1"
  puts test1_allow_ingress
  puts gcp_project_id

  describe google_compute_firewall(project: gcp_project_id, name: test1_allow_ingress) do
    it { should exist }
    it { should allow_ip_ranges ["10.128.0.1/32", "10.128.0.2/32"] }
    its('direction') { should eq 'INGRESS' }
    its('allowed_http?') { should be true }
  end
end
