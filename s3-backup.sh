#!/bin/bash

set -e
set -x

export BACKUP_DAY=$(date +%Y-%b-%d)
export BACKUP_TIME=$(date +%Y-%b-%d-%H%M)

# Set the password for pg_dump
export PGPASSWORD="$DATABASE_PASSWORD"

echo "Backups starting..."

# Create a backup of the attachment and avatar directories in JIRA_HOME/data
echo "Backing up data directory"
mkdir -p /backup/jira/$BACKUP_DAY/
tar -czvf /backup/jira/$BACKUP_DAY/$BACKUP_TIME-jira.tar.gz /var/atlassian/jira/data

# Create a dump of the database
echo "Backing up database"
mkdir -p /backup/jira-db/$BACKUP_DAY/$BACKUP_TIME/
pg_dump -h $DATABASE_HOST -U $DATABASE_USERNAME $DATABASE_NAME > /backup/jira-db/$BACKUP_DAY/$BACKUP_TIME/jira-db.sql

# Cleanup export directory (keep 1 months backups on disk)
find "JIRA_HOME/export/" -type f -iname "*.zip" -mtime +2 -exec rm {} \;
find "/backup/jira/" -type d -mtime +2 -exec rm {} \:
find "/backup/jira-db/" -type d -mtime +2 -exec rm {} \:

# Copy to S3 bucket
echo "Copying data directory to S3"
/usr/local/bin/aws s3 cp --recursive --quiet /backup/jira/ s3://$BUCKET_NAME/jira-backup/data/ || echo "FAILED!"
echo "Copying database backup to S3"
/usr/local/bin/aws s3 cp --recursive --quiet /backup/jira-db/ s3://$BUCKET_NAME/jira-backup/jira-db/ || echo "FAILED!"
echo "Copying export directory to S3"
/usr/local/bin/aws s3 cp --recursive --quiet /var/atlassian/jira/export/ s3://$BUCKET_NAME/jira-backup/export/ || echo "FAILED!"

echo "Backups finished"