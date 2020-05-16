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

Step 4: 

The above step should create two files ({HOME}/.aws/credentials) and ({HOME}/.aws/config). Of interest to this script is the config file whose output is as below

    [default]
    region = us-east-2
    output=json

The value inside the square brackets [default] is the profile name and will be used as an arguement in the script. You can add your own profiles with different regions and with different names as long as they are in the same format as the default profile.


Step 5: 

Log into the AWS console, unders EC2 and create both a ssh key and a security group (you will need its ID)

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html

https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html#CreatingSecurityGroups

Note the ec2 kep pair name and security group id. Also you will need to know the instance type and image id for the instance you intend to deploy. This information is available from the AWS site. The image id and instance type are related and its very easy to pick an image id that is not compatible with a specified instance type.

This information will be fed to an Instance config file that should be similar to the instance_config_sample.txt on this repository.


Step 6

The script can now be used, For directions on how to use run 

aws-create-ec2.sh -h

or

./aws-create-ec2.sh -h
