#!/bin/bash

docker stop forum && docker rm forum
docker stop forum-redis && docker rm forum-redis
