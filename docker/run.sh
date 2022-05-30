#!/bin/bash
source .env

docker run -d -it --name $CONTAINER_NAME \
	-v $ARCHIVE_VOLUME:/data \
	-v $(pwd | sed 's/docker$//')/config:/home/archivebox/archivebox-reddit/config \
	-p $SERVER_HOST_PORT:8000 \
	--restart=unless-stopped \
	fc/archivebox-reddit:latest
