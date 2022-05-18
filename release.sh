#!/bin/bash

source shared.sh

rm -rf archivebox-reddit
git clone --recursive https://github.com/FracturedCode/archivebox-reddit
cd archivebox-reddit
./git-archive-all.sh/git-archive-all.sh
echog "Create a new release"
echog "https://github.com/FracturedCode/archivebox-reddit/releases/new"
echog "and add $(basename $PWD).tar as an asset"
read