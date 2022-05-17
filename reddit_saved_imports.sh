#!/bin/bash

LOG_FILE = /home/ArchiveBox/archivebox/logs/archivebox-reddit-saved-$(date "%Y-%m-%d").log

echo "Grabbing saved from reddit" >> $LOG_FILE
python export-saved-reddit/export_saved.py --all >> $LOG_FILE
echo "Formatting export-saved-reddit output for archivebox" >> $LOG_FILE
python format_csv.py | archivebox add >> $LOG_FILE