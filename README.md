# dq-jira-s3-backup

## Introduction
This image works alongside the UKHomeOffice/jira-docker image, providing periodic backups of Jira to S3.

## Prerequisites
* Jira is running in a separate container
* The container running Jira has a volumeMount in Kube that is shared (or can be shared) with other containers in the pod.

## Usage

The container requires the following environment variabeles to be set:-

Jira database:-

* DATABASE_HOST
* DATABASE_PASSWORD
* DATABASE_PORT
* DATABASE_USERNAME

AWS S3:-

* BUCKET_NAME
* ACCESS_KEY\_ID
* SECRET_ACCESS\_KEY

Backup frequency:-

* CRON_SCHEDULE