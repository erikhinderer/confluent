## Script function: Test Kafka Consumer Functionality
## Author: Erik Hinderer @VMW ehinderer@confluent.io
## Version 1.0
#!/bin/bash
confluent kafka topic consume table18 -b \
  --protocol SASL_SSL \
  --bootstrap "http://bootstrap.kafkacluster.local:19091" \
  --username admin --password secret \
  --value-format avro \
  --ca-location scripts/security/snakeoil-ca-1.crt
done
