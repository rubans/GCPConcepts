# CAP Ingress

The ingress design for CAP is based on the below mentioned considerations



Consideration | Description
------------- | -----------
Filter inbound internet based traffic | The system should have the ability to selectively allow / disallow internet based inbound traffic
DDoS Protection | The system should have the ability to protect against DDoS attacks
Runtime Vulenrability Protection | The system should have the ability to protect against OWasp top 10 vulnerabilities
Protection against DNS Data Exfilteration | The system should have the ability to protect against DNS data exfilteration
Protection against Data Exfilteration | The system should have the ability to protect against data exfilteration
Enforce TLS based communication | The system should have the ability to enforce TLS based communication based on a specific TLS version



## Ingress Design

![CAP ingress design](images/network_overview-Ingress.png)



### Ingress Design Explained

* Ingress is managed at a value stream level
* The ingress traffic flows via Cloud CDN and HTTPS load balancer with Cloud Armor and SSL Policy to the private GKE Cluster hence providing protection against DDoS attacks and OWASP top 10 vulnerabilities
* SSL policy allows TLS based communication using a specific TLS version
* VPC Firewall rules allow only ingress traffic to GKE private cluster environment from the https load balancer and remaining ingress traffic is blocked
* Private GKE Cluster provides restricted access to APIs via Master authorized networks IP address List
