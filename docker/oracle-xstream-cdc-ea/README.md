# Deploy Confluent Platform 7.9.0 with the Oracle XStream CDC Connector EA version via Docker

Resouces: 2 CPUs / 8GB RAM / 16GB DISK

<img width="1792" alt="cp-oraclexstreamcdc-connector" src="https://github.com/user-attachments/assets/7535b2a8-1699-4680-8738-af929965d24a" />

# Usage
1. Pull the Docker image.
```
docker pull erikhinderer/cp-server-connect-oraclexstreamcdc:latest
```
2. Run the Docker image.
```
docker run erikhinderer/cp-server-connect-oraclexstreamcdc:latest
```
3. Veryify the Docker containers are running.
```
docker container ls
```
4. Log into Control Center on http://localhost:9021 and add the Oracle XStream CDC Connector.
5. Configure the Oracle XStream CDC Connector.
