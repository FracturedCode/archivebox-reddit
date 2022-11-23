#!/bin/bash

echo $TZ > /etc/timezone
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

sed -i "s/^.+?(?= archivebox )/${CRON_TIMING}/g" /etc/cron.d/archivebox_scheduled_reddit_saved_import

service cron start