#!/bin/bash

# reddit_saved_imports.sh
# support @ https://github.com/FracturedCode/archivebox-reddit
# GPLv3

export DISPLAY=:0.0
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/node/node_modules/.bin:/venv/bin

BIN=/home/archivebox/archivebox-reddit
LOG_FILE=$BIN/logs/archivebox-reddit-saved-$(date +"%Y-%m-%d").log

cd $BIN

source shared.sh

for ACCOUNT in config/accounts/*.account
do
	cd $BIN
	exportEnv config/.env
	exportEnv $ACCOUNT

	echo "Fetching from reddit"
	python export_saved.py --username $REDDIT_USERNAME --password $REDDIT_PASSWORD --client-id $CLIENT_ID --client-secret $CLIENT_SECRET --all

	CSVS=()
	if [ $SAVE_SUBMISSIONS = "True" ] ; then CSVS+=(submissions) ; fi
	if [ $SAVE_SAVED_COMMENTS_AND_POSTS = "True" ] ; then CSVS+=(saved) ; fi
	if [ $SAVE_COMMENTS = "True" ] ; then CSVS+=(comments) ; fi
	if [ $SAVE_UPVOTES = "True" ] ; then CSVS+=(upvoted) ; fi

	echo "Formatting export-saved-reddit output for archivebox. Archivebox log file: $LOG_FILE"

	for CSV in "${CSVS[@]}"
	do
		cd $BIN
		CSV_FILE="export-$CSV.csv"
		echo Importing $CSV_FILE
		LINKS=$(python format_csv.py $CSV_FILE $REDDIT_FRONTEND)
		touch $LOG_FILE
		cd /data
		echo $LINKS | archivebox add --tag=$EXTRA_ARCHIVEBOX_TAGS,reddit-$CSV,$REDDIT_USERNAME >> $LOG_FILE
	done
done