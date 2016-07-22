
Note: docker-compose doesn't work well yet, use the scripts below instead

```bash
# create necessary volumes
# only need to run this once
./init.sh
```

```bash
# run nginx proxy + letsencrypt
./proxy.sh
```

```bash
# run tradle-server
./start.sh
```

DEPRECATED:

```
docker network create -d bridge nginx-proxy
```
