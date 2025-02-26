# Securely Network Confluent Cloud Connectors to On-Premises Databases

# Introduction
nat2onprem.sh enables you to securely access on-premises resources via your cloud networks. The private access is resource specific as opposed to service specific and protects against data exfiltration in that connectivity can be initiated in only a single direction.

# How It Works
nat2onprem.sh configures a Linux VM with DNAT and SNAT IP Tables rules to provide port forwarding for Confluent Cloud Connectors to reach on-premises databases via the client's cloud network

# IaaS Connectivity
In addition to being able to connect to on-premises resources, you can also securely connect to other VPC / vNET databases.

# Usage in AWS, Azure or GCP
1. Deploy a micro Linux VM within the VPC or vNET that Confluent Cloud is connected to.
2. Copy the nat2onprem.sh script to the Linux VM.
3. Ensure the Linux VM can reach the on-premises database.
```
netcat -z -v mydatabase.mydomain.com 1433
```
4. Run the nat2onprem.sh script on the Linux VM
```
sudo ./nat2onprem.sh -i eth0 -f 1433 -a myonpremdb.mydomain.com -b 1433
```
5. Ensure egress networking is configured in Confluent Cloud for Connectors.
7. Deploy the Confluent Cloud Connector using the IP address of the Linux VM as it's target.
8. Check the Confluent Cloud Connector message count to verify operation.

*Both VPC Peering and PrivateLink connections are supported
