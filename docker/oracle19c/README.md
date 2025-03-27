# Deploy Oracle 19c Database in SingleInstance-NonCDB mode via Docker

1. Copy the image
   
docker pull erikhinderer/oracle-19c

3. Create local directory and change directory to it
   
mkdir -p /your/custom/path/oracle-19c/oradata

cd /your/custom/path/

3. Change ownership of the directory

sudo chown -R 54321:54321 oracle-19c/

4. Run the Container
   
docker run --name oracle-19c
-p 1521:1521
-e ORACLE_SID=[ORACLE_SID]
-e ORACLE_PWD=[ORACLE_PASSWORD]
-e ORACLE_CHARACTERSET=[CHARSET]
-v /your/custom/path/oracle-19c/oradata/:/opt/oracle/oradata
erikhinderer/oracle-19c
