#!/bin/bash

# reddit_saved_imports.sh
# support @ https://github.com/FracturedCode/archivebox-reddit
# GPLv3

LOG_FILE = /home/ArchiveBox/archivebox/logs/archivebox-reddit-saved-$(date "%Y-%m-%d").log

echo "Grabbing saved from reddit"
python export_saved.py --all
echo "Formatting export-saved-reddit output for archivebox. Archivebox log file: $LOG_FILE"
export ONLY_NEW=True SAVE_TITLE=True SAVE_FAVICON=True SAVE_SINGLEFILE=True SAVE_WGET=False SAVE_WARC=False
export SAVE_PDF=False SAVE_SCREENSHOT=False SAVE_DOM=False SAVE_READABILITY=False SAVE_MERCURY=False
export SAVE_GIT=False SAVE_MEDIA=True SAVE_ARCHIVE_DOT_ORG=False COOKIES_FILE=/home/archivebox/archivebox-reddit/cookies-libredd-it.txt
python format_csv.py | archivebox add >> $LOG_FILE