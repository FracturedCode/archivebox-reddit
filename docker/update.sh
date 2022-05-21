#!/bin/bash
docker stop archivebox-reddit
docker rm archivebox-reddit
./build.sh
./run.sh