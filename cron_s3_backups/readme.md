# AWS-Script

A script to backup data folders to Amazon S3

This script is to be used as a cron entry. Frequency is as per users discretion. Also you can change the data folder as per requirement


Step 1: 

You will need to install AWS cli as per the amazon link below

https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html

Step 2: 

Clone the Repository to your prefered location and make sure to make the script file executable. You can also store the script in any executable PATH location.

Step 3: 

Log into you AWS web console and obtain the values for AWS ACCESS KEY ID, AWS SECRET ACCESS KEY and AWS REGION for the user to be used for running the script.

Run the command 

aws configure

Input the values obtained from the web console

This step should create two files ({HOME}/.aws/credentials) and ({HOME}/.aws/config).

Step 4: 

Log into your AWS web console and create a bucket the will be used by the script. You can Edit the script appropriately to reflect the name of your bucket.


Step 5: 

Edit you /etc/crontab file and add the entry below. This will run the script daily at 1:00AM as user root

The format of /etc/crontab is like this:

# Everyday at 1:00AM
# m h dom mon dow user      command
0 1 * * *  root  cron_s3_backups.sh
