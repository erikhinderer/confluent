# Deploy Confluent Platform with Oracle XStream CDC v1beta Connector via Docker

# Introduction
This Dockerfile creates a Docker Image with Confluent Platform and the early access version Oracle XStream CDC Connector

# Instructions
1. Create a directory for the Dockerfile.
```
mkdir /srv/docker/cp-connect-oracle-xstream-demo
```
2. Download the Dockerfile to the directory with wget.
```
wget https://github.com/erikhinderer/confluent/blob/main/docker/confluent-platform-connect-oracle-xstream-cdc/Dockerfile
```
4. Create a local Docker Registry for the image.
```
docker run -d -p 5000:5000 --name local-registry registry:2
```
5. Build the Confluent Platform cluster docker image with the Oracle XStream CDC Connector installed.
```
docker build . -t cp-connect-oracle-xstream-demo:1.0.1
```
6. Verify the image was created in the Docker Registry.
```
docker image ls
```
7. Run the Docker image.
```
docker run -it <your docker repository>/cp-connect-oracle-xstream-demo:1.0.1
```
8. Open Confluent Control Center in a browser to verify.
```
http://localhost:9021
```
