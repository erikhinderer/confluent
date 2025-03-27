# Confluent Platform 7.9.0 with Connect and the Oracle XStream CDC Connector EA version

<img width="1792" alt="cp-oraclexstreamcdc-connector" src="https://github.com/user-attachments/assets/7535b2a8-1699-4680-8738-af929965d24a" />

# Usage
1. Copy the Dockerfile and docker-compose.yml to a directory.
2. Compose the Docker image up with detached mode.
```
docker compose up -d
```
3. Veryify the Docker Image is pulled and containers are running.
```
docker container ls
```
4. Veryify the Docker Image is pulled and containers are running.
```
docker container ls
```
5. Add and configure the Confluent Platform Oracle XStream CDC Connector via Control Center.
```
Open http://localhost:9021 in a web browser and navigate to the Connect Cluster and Add Connector
...
