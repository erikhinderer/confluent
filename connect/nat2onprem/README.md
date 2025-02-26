# Securely Network Confluent Cloud Connectors to On-Premises Databases

# Introduction
nat2onprem.sh enables you to securely access on-premises resources via your cloud networks. The private access is resource specific as opposed to service specific and protects against data exfiltration in that connectivity can be initiated in only a single direction.

# How It Works
nat2onprem.sh configures a Linux VM with DNAT and SNAT IP Tables rules to provide port forwarding for Confluent Cloud Connectors to reach on-premises databases via the client's cloud network

# IaaS Connectivity
In addition to being able to connect to on-premises resources, you can also securely connect to other VPC / vNET databases.

# General Usage in AWS, Azure or GCP
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
5. Deploy the Confluent Cloud Connector using the IP address of the Linux VM as it's target.
6. Check the Confluent Cloud Connector message count to verify operation.

# Using a Bastion Host for connectivity from an Azure vNET to an On-Premises Database

1. Implementing the Forwarding Solution:
```
# ALLOWED_IP_ADDRESS is the allowed IP Address from which you'll connect
# to the Bastion VM via SSH. Be sure to add the /32 CIDR at the end
export ALLOWED_IP_ADDRESSES="aaa.bbb.ccc.ddd"

# Login to Azure
az login 

# Create resource group for forwarding
az group create -n az-fwd-rg -l eastus

# Create Forwarding VNET and backend subnet to host VMs
az network vnet create \
   -g az-fwd-rg \
   -n az-fwd-vnet \
   --address-prefixes 10.100.0.0/22 \
   --subnet-name be-subnet \
   --subnet-prefixes 10.100.0.0/24 \
   -l eastus

# Create Frontend subnet for Standard Internal Load Balancer 
az network vnet subnet create \
   -g az-fwd-rg \
   -n fe-subnet \
   --vnet-name az-fwd-vnet \
   --address-prefix 10.100.1.0/24 

# Create PLS subnet for Private Link Service
az network vnet subnet create \
   -g az-fwd-rg \
   -n pls-subnet \
   --vnet-name az-fwd-vnet \
   --address-prefix 10.100.2.0/24 

az network vnet subnet update \
   -g az-fwd-rg \
   -n pls-subnet \
   --vnet-name az-fwd-vnet \
   --disable-private-link-service-network-policies true

# Create Bastion subnet for locked down Internet access
az network vnet subnet create \
   -g az-fwd-rg \
   -n bast-subnet \
   --vnet-name az-fwd-vnet \
   --address-prefix 10.100.3.0/24 

# Create Network Security Group for locked down access to bast-subnet
az network nsg create -g az-fwd-rg --name bastion-nsg

# Create NSG rule to allow Internet access from your IP.
# NOTE: ENTER FILL YOUR IP a.b.c.d/32 in the --source-address-prefix option
az network nsg rule create \
   -g az-fwd-rg \
   --nsg-name bastion-nsg \
   --name AllowSSH \
   --direction inbound \
   --source-address-prefix ${ALLOWED_IP_ADDRESSES} \
   --destination-port-range 22 \
   --access allow \
   --priority 500 \
   --protocol Tcp

# Assign NSG to Bastion subnet
az network vnet subnet update \
   -g az-fwd-rg \
   -n bast-subnet \
   --vnet-name az-fwd-vnet \
   --network-security-group bastion-nsg
# Create Bastion VM
az vm create \
   -g az-fwd-rg \
   --name bastionvm \
   --image UbuntuLTS \
   --admin-user azureuser \
   --generate-ssh-keys \
   --vnet-name az-fwd-vnet \
   --subnet bast-subnet

# Create Standard Internal Load Balancer
az network lb create \
   -g az-fwd-rg \
   --name FWDILB \
   --sku standard \
   --vnet-name az-fwd-vnet \
   --subnet fe-subnet \
   --frontend-ip-name FrontEnd \
   --backend-pool-name bepool

# Create a health probe to monitor the health of VMs using port 22
az network lb probe create \
   -g az-fwd-rg \
   --lb-name FWDILB \
   --name SSHProbe \
   --protocol tcp \
   --port 22

# Create an LB rule to forward SQL packets on 1433 to backend NAT VM on 1433
az network lb rule create \
   -g az-fwd-rg \
   --lb-name FWDILB \
   --name OnPremSQL \
   --protocol tcp \
   --frontend-port 1433 \
   --backend-port 1433 \
   --frontend-ip-name FrontEnd \
   --backend-pool-name bepool \
   --probe-name SSHProbe

# Get ILB Resource ID
FWD_ILB=$(az network lb show -g az-fwd-rg -n FWDILB --query frontendIpConfigurations[0].id -o tsv)
# Create Private Link Service to ILB
PLS_ID=$(
   az network private-link-service create \
      -g az-fwd-rg \
      -n pls2fwdilb \
      --vnet-name az-fwd-vnet \
      --subnet pls-subnet \
      --lb-frontend-ip-configs ${FWD_ILB} \
      -l eastus \
      --query id \
      -o tsv)

# Create NIC for the VM
NIC_NAME=fwdvm1nic${RANDOM}
az network nic create \
   -g az-fwd-rg \
   -n ${NIC_NAME} \
   --vnet-name az-fwd-vnet \
   --subnet be-subnet

# Create backend forwarding Linux VM
az vm create \
   -g az-fwd-rg \
   --name natvm1 \
   --image UbuntuLTS \
   --admin-user azureuser \
   --generate-ssh-keys \
   --nics ${NIC_NAME}

# Add NIC to LB
az network nic ip-config address-pool add \
   --address-pool bepool \
   --ip-config-name ipconfig1 \
   --nic-name ${NIC_NAME} \
   -g az-fwd-rg \
   --lb-name FWDILB

# Print PLS ID to use for connection to this PLS
echo "PLS ID is ${PLS_ID}"

# Print Bastion VM Public IP
echo "Bastion Public IP is: $(az vm show -d -g az-fwd-rg -n bastionvm --query publicIps -o tsv)"
```
2. Creating Forwarding Rule to Endpoint
   * Copy nat2oonprem.sh to the Bastion VM and then to each of the NAT VMs
   * Run the script on each VM with the following options:  
     ```sudo ./nat2onprem.sh -i eth0 -f 1433 -a <FQDN/IP> -b 1433```  
     This will forward packets coming in on Ethernet Interface ```eth0``` on port ```1433``` to the ```Destination FQDN or IP of the on-prem SQL Server``` on port ```1433```



