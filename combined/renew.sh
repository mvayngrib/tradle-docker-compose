#!/bin/bash

source .env
docker stop nginx
certbot renew --quiet --force-renew && \
  mkdir -p /var/proxy/certs && \
  ./copy.sh /etc/letsencrypt/live/ /var/proxy/certs/

docker restart nginx
