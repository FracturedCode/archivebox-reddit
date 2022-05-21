#!/bin/bash

# install.sh
# support @ https://github.com/FracturedCode/archivebox-reddit
# GPLv3

echo Bootstrapping...

if test ! -f "shared.sh"
then
	curl -O https://raw.githubusercontent.com/FracturedCode/archivebox-reddit/master/shared.sh
fi

source shared.sh

# https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
get_latest() {
	curl --silent "https://api.github.com/repos/FracturedCode/archivebox-reddit/releases/latest" |
    grep \"$1\" |
    sed -E 's/.*"([^"]+)".*/\1/'
}

if [ "$1" != "--dockerfile" ]
then
	echog "Downloading and extracting temporary source"
	TAR_FILE=$(get_latest tag_name).tar.gz
	UNZIPPED_TAR_DIR=$TAR_FILE-unzipped
	curl --progress-bar -L -o $TAR_FILE $(get_latest browser_download_url)
	mkdir -p $UNZIPPED_TAR_DIR
	tar -xf $TAR_FILE -C ./$UNZIPPED_TAR_DIR
	cd $UNZIPPED_TAR_DIR
fi

echog "Installing praw via pip"
pip install -r export-saved-reddit/requirements.txt

echog "Installing cron job for every 24 hours"
export ARCHIVEBOX_BIN=/home/archivebox/archivebox-reddit/
mkdir -p $ARCHIVEBOX_BIN
INSTALL_FILES=("reddit_saved_imports.sh" "format_csv.py" "export-saved-reddit/export_saved.py" ".env" "cookies-libredd-it.txt")
for file in $INSTALL_FILES
do
	cp $file $ARCHIVEBOX_BIN
done
chown -R archivebox:archivebox $ARCHIVEBOX_BIN
chmod +x "${ARCHIVEBOX_BIN}reddit_saved_imports.sh"
chmod +x "${ARCHIVEBOX_BIN}yt-dlp.sh"
echo '0 24 * * * archivebox ${ARCHIVEBOX_BIN}reddit_saved_imports.sh' > /etc/cron.d/archivebox_scheduled_reddit_saved_import

if [ "$1" != "--dockerfile" ]
then
	echog "Nuking temporary source"
	cd ..
	rm -rf $UNZIPPED_TAR_DIR
	rm $TAR_FILE
fi

echog "Install script complete. This is a dumb script, so check for errors in the output"


# TODO think about how logging is setup