## Script function: Test Kafka Consumer Functionality
## Author: Erik Hinderer @erikhinderer
## Version 1.0
#!/bin/bash
confluent kafka topic consume table18 -b \
  --protocol SASL_SSL \
  --bootstrap "http://kafkacluster.bootstrap.url:19091" \
  --username admin --password secret \
  --value-format avro \
  --ca-location scripts/security/snakeoil-ca-1.crt
done
