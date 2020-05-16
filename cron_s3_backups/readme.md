# AWS-Script
A script to deploy EC2 Instances on AWS

This script takes a two arguements, your profile (which defines the region to create the EC2 instance) and a file path for the file that contains information about the instance(Instances) you wish to spin up.


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


Step 5: 

Edit you /etc/crontab file and add the entry below

aws-create-ec2 -h

or

./aws-create-ec2.sh -h
