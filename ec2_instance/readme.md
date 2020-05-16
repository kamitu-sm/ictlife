# AWS-Script
A script to deploy EC2 Instances on AWS

This script takes a two arguements, your profile (which defines the region to create the EC2 instance) and a file path for the file that contains your security group id and ssh key name that your instance will be using.


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

Step 4: 

The above step should create two files (~/.aws/credentials) and (~/.aws/config). Of interest to this script is the config file whose output is as below

[default]

region = us-east-2

output=json

The value inside the square brackets (default) is the profile arguement that will be used in the script. You can add your own profiles with different regions


Step 5: 

Log into the AWS console, unders EC2 and create both a ssh key and a security group (you will need its ID)

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html

https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html#CreatingSecurityGroups

Store the pem key name and security group id inside a file that you will pass as the second arguement.

The file should contain the below two entries as shown

AWS_SECURITY_GRP_ID=xxxxxxxxxxxxxxxxxx

AWS_SSH_KEY_NAME=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx



Step 6

The script can now be used, For directions on how to use run 

aws-create-ec2 -h

or

./aws-create-ec2.sh -h
