#!/bin/bash
#
# Coder is Stephen Kamitu Munguti -> kamitu.sm@gmail.com
#
# Be sure to have followed the instructions in the readme for the repository 
#
#####################################################################
#                                                                   #
#                                                                   #
#                     Define Gloabal Variables                      # 
#                                                                   #
#                                                                   #
#####################################################################

# Get the date and time for when the command is run
current_time=$(date "+%d-%m-%Y--%H-%M")
echo "Current Time : $current_time"


# Specify log file for the scripts
LOG_FILE="/var/log/cron_s3_backups_output.log"

# Check if output file exists if not create it
if [[ ! -f $LOG_FILE ]]; then
	touch $LOG_FILE
fi

# Run the aws s3 backup command but first echo date of script runtime to log file
echo $current_time >> $LOG_FILE

# Assuming that you have a bucket name my-first-backup-bucket on Amazon s3 and your local database PGDATA is at /db/apps/pgdata
# Assuming that your backups directory is /db/backups/
# Create the tar files

filename="/db/backups/${current_time}_db.bak.tar.gz"
echo "Creating Tar file for database" >> $LOG_FILE
tar -czvf "$filename" /db/apps/pgdata >> $LOG_FILE 2>&1

# Copy to S3
echo "Copying to S3" >> $LOG_FILE
aws s3 cp "$filename" s3://my-first-backup-bucket/ >> $LOG_FILE 2>&1

echo "Command Completed" >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE
