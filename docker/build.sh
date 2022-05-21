#!/bin/bash
docker build \
	-t fc/archivebox-reddit:latest \
	-t fc/archivebox-reddit:$(date +"%Y-%m-%d") \
	-t fc/archivebox-reddit:$(date +%s%3N) \
	--progress=plain \
	-f Dockerfile \
	../