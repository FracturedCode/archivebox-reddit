#!/bin/bash

# reddit_saved_imports.sh
# support @ https://github.com/FracturedCode/archivebox-reddit
# GPLv3

export DISPLAY=:0.0
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/node/node_modules/.bin:/venv/bin
export $(grep -v '^#' /home/archivebox/archivebox-reddit/.env | xargs)

LOG_FILE=/home/archivebox/archivebox-reddit/logs/archivebox-reddit-saved-$(date +"%Y-%m-%d").log

cd /home/archivebox/archivebox-reddit
echo "Fetching from reddit"
python export_saved.py --username $REDDIT_USERNAME --password $REDDIT_PASSWORD --client-id $CLIENT_ID --client-secret $CLIENT_SECRET --all

CSVS=()
if $SAVE_SUBMISSIONS ; then CSVS+=export-submissions ; fi
if $SAVE_SAVED_COMMENTS_AND_POSTS ; then CSVS+=export-saved ; fi
if $SAVE_COMMENTS ; then CSVS+=export-comments ; fi
if $SAVE_UPVOTES ; then CSVS+=export-upvoted ; fi

echo "Formatting export-saved-reddit output for archivebox. Archivebox log file: $LOG_FILE"
cd /data

for CSV in "${CSVS[@]}"
do
	CSV="$CSV.csv"
	echo Importing $CSV
	LINKS=$(python format_csv.py $CSV)
	touch $LOG_FILE
	echo $LINKS | archivebox add >> $LOG_FILE
done