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

echog "Downloading and extracting temporary source"
TAR_FILE=$(get_latest tag_name).tar.gz
UNZIPPED_TAR_DIR=$TAR_FILE-unzipped
curl --progress-bar -L -o $TAR_FILE $(get_latest browser_download_url)
mkdir -p $UNZIPPED_TAR_DIR
tar -xf $TAR_FILE -C ./$UNZIPPED_TAR_DIR
cd $UNZIPPED_TAR_DIR
ACCOUNT_DETAILS=export-saved-reddit/AccountDetails.py

echog "Installing praw via pip"
pip install -r export-saved-reddit/requirements.txt

echog "Setting up account details"
cp details_message.txt $ACCOUNT_DETAILS
echo >> $ACCOUNT_DETAILS
cat $ACCOUNT_DETAILS.example >> $ACCOUNT_DETAILS
"${EDITOR:-nano}" $ACCOUNT_DETAILS

echog "Installing cron job for every 24 hours"
ARCHIVEBOX_BIN = /home/ArchiveBox/archivebox/bin/archivebox-reddit/
mkdir -p $ARCHIVEBOX_BIN
cp reddit_saved_imports.sh $ARCHIVEBOX_BIN
cp export-saved-reddit/export_saved.py $ARCHIVEBOX_BIN
cp export-saved-reddit/AccountDetails.py $ARCHIVEBOX_BIN
echo '0 24 * * * archivebox ${ARCHIVEBOX_BIN}reddit_saved_imports.sh' > /etc/cron.d/archivebox_scheduled_reddit_saved_import


echog "Nuking temporary source"
rm -rf $UNZIPPED_TAR_DIR

echog "Install script complete. This is a dumb script, so check for errors in the output"


# TODO think about how logging is setup