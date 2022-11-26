#!/bin/bash
git pull
git submodule update --recursive
./build.sh
./recreate.sh
