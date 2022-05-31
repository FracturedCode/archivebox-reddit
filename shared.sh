#!/bin/bash

# shared.sh
# support @ https://github.com/FracturedCode/archivebox-reddit
# GPLv3

# Used by other scripts to print in green
echog() {
	GREEN='\033[0;32m'
	NOCOLOR='\033[0m'
	echo -e "${GREEN}${@}${NOCOLOR}"
}

exportEnv() {
	export $(grep -v '^#' $1 | xargs)
}