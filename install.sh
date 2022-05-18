#!/bin/bash

# install.sh
# support @ https://github.com/FracturedCode/archivebox-reddit
# GPLv3

source shared.sh

echoAd() {
	echo -e "${@}" >> $ACCOUNT_DETAILS
}

# https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
get_latest() {
	curl --silent "https://api.github.com/repos/FracturedCode/archivebox-reddit/releases/latest" |
    grep \"$1\" |
    sed -E 's/.*"([^"]+)".*/\1/'
}

echog "Downloading and extracting source"
TAR_FILE=$(get_latest tag_name).tar.gz
curl --progress-bar -L -o $TAR_FILE $(get_latest browser_download_url)
mkdir -p archivebox-reddit
tar -xf $TAR_FILE -C ./archivebox-reddit
cd archivebox-reddit
ACCOUNT_DETAILS=export-saved-reddit/AccountDetails.py

echog "Downloading dependencies"
pip install -r export-saved-reddit/requirements.txt

echog "Setting up account details"
cp details_message.txt $ACCOUNT_DETAILS
cat $ACCOUNT_DETAILS.example >> $ACCOUNT_DETAILS
nano $ACCOUNT_DETAILS

#echog "Installing cron job"
#ARCHIVEBOX_BIN = /home/ArchiveBox/archivebox/bin/
#cp ${SRC}reddit_saved_imports.sh $ARCHIVEBOX_BIN
#chmod +x $ARCHIVEBOX_BIN/reddit_saved_imports.sh
#echo '0 24 * * * archivebox ${ARCHIVEBOX_BIN}reddit_saved_imports.sh' > /etc/cron.d/archivebox_scheduled_reddit_saved_import
#
#echog "Install script complete. Check for errors in the output"
#

# TODO think about how logging is setup
# TODO maybe have a cutoff so archivebox doesn't have to hunt whether or not stuff has already been archived