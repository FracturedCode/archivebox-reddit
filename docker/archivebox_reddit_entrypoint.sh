#!/bin/bash

echo $TZ > /etc/timezone
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

CRON_JOB_FILE=/etc/cron.d/archivebox_scheduled_reddit_saved_import
perl -pe "s/^.+?(?= archivebox )/${CRON_TIMING}/g" <<< `cat $CRON_JOB_FILE` > $CRON_JOB_FILE

service cron start