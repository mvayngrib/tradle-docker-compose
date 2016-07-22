#!/bin/bash

source .env
docker stop nginx
certbot renew --quiet --force-renew && mkdir -p /var/proxy/certs && cp -L "/etc/letsencrypt/live/${TRADLE_SERVER_URL}"*/* /var/proxy/certs/
docker restart nginx
