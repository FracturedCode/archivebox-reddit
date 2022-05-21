#!/bin/bash
source .env
git pull
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
./build.sh
./run.sh