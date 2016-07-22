#!/bin/bash

source .env
./stop.sh
certbot renew --quiet --force-renew && mkdir -p /var/proxy/certs && cp -L "/etc/letsencrypt/live/${TRADLE_SERVER_URL}"*/* /var/proxy/certs/
./restart.sh
