#!/bin/bash

# This an example service that will get picked up and served by the reverse proxy.
# Make sure you change all the default values in this file and in volumes/examples/simple-site
echo "Starting Tradle server..."
docker run -d \
    --name tradle-server \
    -e "VIRTUAL_HOST=${TRADLE_SERVER_URL}" \
    -e VIRTUAL_PORT=80 \
    -e TRADLE_SERVER_PORT=80
    -e "LETSENCRYPT_HOST=${TRADLE_SERVER_URL}" \
    -e LETSENCRYPT_EMAIL=${DEV_EMAIL} \
    -e NODE_ENV=development \
    -e AUTORUN=1 \
    -e DEBUG=* \
    -e HOME=/home \
    -e CONF_PATH=./conf \
    -e STORAGE_PATH=./storage \
    -v ./tradle-server-conf.d/:/etc/nginx/conf.d \
    -v tradle_data_2:/opt/app/storage \
    -v tradle_conf_2:/opt/app/conf \
    --expose 80 \
    tradle/server-cli:v2
