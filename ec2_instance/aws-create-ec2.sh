#!/bin/bash

# Prereqs:
#  Make sure to have installed the aws cli
#  Make sure to have run the command aws configure 
#  Default credentials file (~/.aws/credentials)
#  Default configuration file (~/.aws/config)
#  Profile name will choose the region (should have an entry in config ini file)
#  Make sure to have installed jq
# Must have SSH key preconfigured
# Must have security group preconfigured
# Make sure to have the image id of your EC2 instance will be based on (This also related to the instance type too) 


# Get the date and time for when the command is run
current_time=$(date "+%d-%m-%Y--%H-%M")
echo "Current Time : $current_time"

# Specify file for storing the output
FILE="./$current_time-aws_create.txt"


if [ "$#" -ne 2 ]; then
    echo "[-] Usage: run $0 <aws profile name> <key-name>"
    exit 1
fi


profile=$1 # The name of local profile to be used.
keyName=$2 # The name of the SSH key you'd like to use to log into the EC2 instance. Must already exist in ec2.

# Creates an instance of whatever you want.
aws ec2 run-instances --profile "$profile" --key-name "$keyName" --image-id ami-0f7919c33c90f5b58 --count 1 --instance-type t2.micro  --security-group-ids sg-0d603a01c354e4b2d --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=ICTLIFE}]' > $FILE

# Collect the new instance ID and Availability Zone
instanceID=$(jq -r '.Instances[].InstanceId' < $FILE)
availabilityZone=$(jq -r '.Instances[].Placement.AvailabilityZone' < $FILE)


echo "[+] Created Instance $instanceID in Availability Zone $availabilityZone "
