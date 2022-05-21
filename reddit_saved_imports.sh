#!/bin/bash

# reddit_saved_imports.sh
# support @ https://github.com/FracturedCode/archivebox-reddit
# GPLv3

export DISPLAY=:0.0
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/node/node_modules/.bin:/venv/bin
export $(grep -v '^#' /home/archivebox/archivebox-reddit/.env | xargs)

LOG_FILE=/home/archivebox/archivebox-reddit/logs/archivebox-reddit-saved-$(date +"%Y-%m-%d").log

cd /home/archivebox/archivebox-reddit
echo "Grabbing saved from reddit"
python export_saved.py --username $REDDIT_USERNAME --password $REDDIT_PASSWORD --client-id $CLIENT_ID --client-secret $CLIENT_SECRET --all
echo "Formatting export-saved-reddit output for archivebox. Archivebox log file: $LOG_FILE"
LINKS=$(python format_csv.py)
cd /data
touch $LOG_FILE
echo $LINKS | archivebox add >> $LOG_FILE