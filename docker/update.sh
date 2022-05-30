#!/bin/bash
source .env
git pull
git submodule update --recursive
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
./build.sh
./run.sh