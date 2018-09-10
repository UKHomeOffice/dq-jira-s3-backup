#!/bin/bash

set -e

CRON_SCHEDULE=${CRON_SCHEDULE:-0 1 * * *}

echo "access_key=$ACCESS_KEY" >> /root/.s3cfg
echo "secret_key=$SECRET_KEY" >> /root/.s3cfg

LOGFILE='/var/log/cron.log'
if [[ ! -e "$LOGFILE" ]]; then
    mkfifo "$LOGFILE"
fi

echo -e "$CRON_SCHEDULE /s3-backup.sh > $LOGFILE 2>&1" | crontab -
crontab -l
cron
tail -f "$LOGFILE"
