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
FILE="/var/log/cron_s3_backups_output.txt"

# Check if output file exists if not create it
if [[ ! -f $FILES ]]
	then
		touch $FILE
fi
