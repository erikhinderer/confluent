## Script function: Test Kafka Consumer Functionality
## Author: Erik Hinderer @VMW ehinderer@confluent.io
## Version 1.0
#!/bin/bash
confluent kafka topic consume table18 -b \
  --protocol SASL_SSL \
  --bootstrap ":19091" \
  --username admin --password secret \
  --value-format avro \
  --sr-endpoint https://localhost:8085 \
  --ca-location scripts/security/snakeoil-ca-1.crt
done