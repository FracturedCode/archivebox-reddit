#!/bin/bash

# reddit_saved_imports.sh
# support @ https://github.com/FracturedCode/archivebox-reddit
# GPLv3

LOG_FILE = /home/ArchiveBox/archivebox/logs/archivebox-reddit-saved-$(date "%Y-%m-%d").log

echo "Grabbing saved from reddit"
python export-saved-reddit/export_saved.py --all
echo "Formatting export-saved-reddit output for archivebox. Archivebox log file: $LOG_FILE"
python format_csv.py | archivebox add >> $LOG_FILE