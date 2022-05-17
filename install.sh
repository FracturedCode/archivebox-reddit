ACCOUNT_DETAILS = archivebox-reddit/export-saved-reddit/AccountDetails.py

echog "Downloading and extracting source"
curl <releasehere>
tar -xf <releasehere> -C ./archivebox-reddit

echog "Downloading dependencies"
pip install -r archivebox-reddit/export-saved-reddit/requirements.txt

echog "Setting up account details"
cp $ACCOUNT_DETAILS.example $ACCOUNT_DETAILS
echoAd "# You must input your reddit account details here. If you don't know what some of these parameters are read this:"
echoAd "# https://github.com/csu/export-saved-reddit#usage"
echoAd "# Additionally, this is a python script, so you must escape any special characters:"
echoAd "# https://www.w3schools.com/python/gloss_python_escape_characters.asp"
nano $ACCOUNT_DETAILS

echog "Installing cron job"
ARCHIVEBOX_BIN = /home/ArchiveBox/archivebox/bin/
cp archivebox-reddit/reddit_saved_imports.sh $ARCHIVEBOX_BIN
chmod +x $ARCHIVEBOX_BIN/reddit_saved_imports.sh
echo '0 24 * * * archivebox ${ARCHIVEBOX_BIN}reddit_saved_imports.sh' > /etc/cron.d/archivebox_scheduled_reddit_saved_import

echog "Install script complete. Check for errors in the output"

echog() {
	GREEN='\033[0;32m'
	NOCOLOR='\033[0m'
	echo -e "${GREEN}${@}${NOCOLOR}"
}

echoAd() {
	echo -e "${@}" >> $ACCOUNT_DETAILS
}