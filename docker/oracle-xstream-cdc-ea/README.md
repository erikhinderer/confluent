# Deploy Confluent Platform 7.9.0 with the Oracle XStream CDC Connector EA version via Docker

Resouces: 2 CPUs / 8GB RAM / 16GB DISK

<img width="1792" alt="cp-oraclexstreamcdc-connector" src="https://github.com/user-attachments/assets/7535b2a8-1699-4680-8738-af929965d24a" />

# Usage
1. Copy the docker-compose.yml to a directory.
```
wget https://github.com/erikhinderer/confluent/blob/main/docker/oracle-xstream-cdc-ea/docker-compose.yml
```
3. Compose the Docker image up in detached mode.
```
docker compose up -d
```
3. Veryify the Docker Image is pulled.
```
docker image ls
```
4. Veryify the Docker containers are running.
```
docker container ls
```
5. Log into Control Center on http://localhost:9021 and add the Oracle XStream CDC Connector.
6. Configure the Oracle XStream CDC Connector.
