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


# Specify file for storing the output
FILE="./$current_time-aws_create_instance_output.txt"



#####################################################################
#                                                                   #
#                                                                   #
#                      Define your Functions                        # 
#                                                                   #
#                                                                   #
#####################################################################
# Make file readable first variable is command second is output file
instance_config_sample () {
	echo "#Security group to be applied to instance"
	echo "AWS_SECURITY_GRP_ID=sg-0d603a01c354e4b2d"
	echo ""
	echo "# SSH Key Name to be used for SSH access"
	echo "AWS_SSH_KEY_NAME=amazon-ec2-instance-1"
	echo ""
	echo "# Image EC2 instance will be based on"
	echo "AWS_IMAGE_ID=ami-0f7919c33c90f5b58"
	echo ""
	echo "# Number of instances to spin up and the instance type they are to be based on"
	echo "AWS_EC2_COUNT=1"
	echo "AWS_INSTANCE_TYPE=t2.micro"
}

# The actual script rememeber $1 is profile and $2 is instance config file
run_script () {
	# Check if output file exists if not create it and if it exists empty it
	if [[ ! -f $FILES ]]
	then
		touch $FILE
	else
		cat /dev/null > $FILE
	fi

	#Set the env variables from credential file sent by user
	AWS_SECURITY_GRP_ID=$(awk -F\= '/^AWS_SECURITY_GRP_ID/{print $2}' $2)
	AWS_SSH_KEY_NAME=$(awk -F\= '/^AWS_SSH_KEY_NAME/{print $2}' $2)

	AWS_IMAGE_ID=$(awk -F\= '/^AWS_IMAGE_ID/{print $2}' $2)
	AWS_EC2_COUNT=$(awk -F\= '/^AWS_EC2_COUNT/{print $2}' $2)
	AWS_INSTANCE_TYPE=$(awk -F\= '/^AWS_INSTANCE_TYPE/{print $2}' $2)

	# Verify existence of the variables in the security credential file
	if [[	$AWS_SECURITY_GRP_ID == "" || 
		$AWS_SSH_KEY_NAME == "" || 
		$AWS_IMAGE_ID == "" || 
		$AWS_EC2_COUNT == "" ||  
		$AWS_INSTANCE_TYPE == "" 
	]]; then
		echo "Issue with instance configuration file, please check your file!"
		echo "(run $0 -h for help)"
		exit 0
	fi


	######################################################
	################ CREATE THE INSTANCE #################
	echo "Running the Scripts"
	profile=$1 # The name of local profile to be used.

	# Creates an instance of whatever you want.
	aws ec2 run-instances --profile "$profile" --key-name "$AWS_SSH_KEY_NAME" --image-id "$AWS_IMAGE_ID" --count "$AWS_EC2_COUNT" --instance-type "$AWS_INSTANCE_TYPE"  --security-group-ids "$AWS_SECURITY_GRP_ID" --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Script_Webserver}]' > $FILE

	# Collect the new instance ID and Availability Zone
	instanceID=$(jq -r '.Instances[].InstanceId' < $FILE)
	availabilityZone=$(jq -r '.Instances[].Placement.AvailabilityZone' < $FILE)


	echo "[+] Created Instance $instanceID in Availability Zone $availabilityZone "
	echo "Output Stored in $FILE"

}



#####################################################################
#                                                                   #
#                                                                   #
#                     The script main function                      # 
#                                                                   #
#                                                                   #
#####################################################################


# if the command is run without any options
if [ $# -eq 0 ]
then
        echo "Missing options!"
        echo "(run $0 -h for help)"
        echo ""
        exit 0
fi

# if the command is run without valid options
if [[ $# -gt 3 || ( $1 != "-c" && $1 != "-h" ) ]]
then
        echo "Invalid option or too many arguements!"
        echo "(run $0 -h for help)"
        echo ""
        exit 0
fi

# Check options and arguements tally 
if [[ ($1 == "-c" && $# -ne 3) || ($1 == "-h" && $# -ne 1) ]]
then
        echo "You have selected -c with missing arguements!"
        echo "OR you have selected -h with unecessary arguements!"
        echo "(run $0 -h for help)"
        echo ""
        exit 0
fi

# if the selected option is c  check if the credential file exists 
if [[ $1 == "-c" && ! (-f "$3") ]]
then
        echo "The credential file $3 does not exist!"
        echo ""
        exit 0
fi

RUN_SCRIPT="false"

while getopts "hc" OPTION; do
        case $OPTION in

                c)
                        RUN_SCRIPT="true"
                        ;;

                h)
                        echo "Usage:"
                        echo "aws_script.sh -h "
                        echo "aws_script.sh -c profile_name intance_config_file"
                        echo ""
                        echo "   -c  profile_name [intance_config_file_path]  -> (to execute script)"
                        echo "   -h  -> (this output)"
			echo ""
                        echo "Make sure your instance configuration file is as per the format"
			instance_config_sample
			echo ""
                        exit 0
                        ;;

        esac
done

if [ $RUN_SCRIPT = "true" ]
then
	#run_script (profile) (instance_config_file)
	run_script $2 $3;
fi

