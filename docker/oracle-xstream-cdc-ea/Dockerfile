FROM confluentinc/cp-server-connect:7.9.0
USER root
RUN confluent-hub install --no-prompt confluentinc/kafka-connect-oracle-xstream-cdc-source:0.2.0-ea
RUN confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.8.0
RUN cd /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib && curl -O https://redshift-downloads.s3.amazonaws.com/drivers/jdbc/2.1.0.30/redshift-jdbc42-2.1.0.30.jar
USER 1001
