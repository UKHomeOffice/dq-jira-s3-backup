#!/bin/bash

set -e

CRON_SCHEDULE=${CRON_SCHEDULE:-0 1 * * *}

LOGFILE='/var/log/cron.log'
if [[ ! -e "$LOGFILE" ]]; then
    mkfifo "$LOGFILE"
fi

echo -e "$CRON_SCHEDULE /s3-backup.sh > $LOGFILE 2>&1" | crontab -
crontab -l
cron
tail -f "$LOGFILE"
