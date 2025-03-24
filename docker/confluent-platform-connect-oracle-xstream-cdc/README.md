# Deploy Confluent Platform with Oracle XStream CDC v1beta Connector via Docker

# Introduction
This Dockerfile creates a Docker Image with Confluent Platform and the early access version Oracle XStream CDC Connector

# Instructions
1. Create a directory for the Dockerfile.
```
mkdir /srv/docker/cp-connect-oracle-xstream-demo
```
2. Ensure the Linux VM can reach the on-premises database.
```
netcat -z -v mydatabase.mydomain.com 1433
```
4. Run the nat2onprem.sh script on the Linux VM.
```
sudo ./nat2onprem.sh -i eth0 -f 1433 -a myonpremdb.mydomain.com -b 1433
```

