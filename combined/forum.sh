#!/bin/bash

source .env

# redis with persistence on the same network as the nginx server
docker run --name forum-redis -p 6379 --net combined_default -d redis redis-server --appendonly yes

# run forum on the same network as the nginx server (combined)
docker run -it --name forum --link forum-redis:redis --net combined_default -e VIRTUAL_HOST=${TRADLE_FORUM_URL} -e VIRTUAL_PORT=4567 tradle/forum
