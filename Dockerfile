FROM debian:jessie

LABEL maintainer="dqdevops@homeoffice.gsi.gov.uk"

# Update, install python, pip and cron
RUN apt-get update --quiet && \
    apt-get install --quiet --yes python python-pip cron

# Add AWS Cli tool
RUN pip install awscli --upgrade

# Add postgresql-client
RUN apt-get install --quiet --yes postgresql-client

# Copy in backup script
ADD s3-backup.sh /s3-backup.sh
RUN chmod +x /s3-backup.sh

# Copy in start script
ADD start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
CMD [""]
