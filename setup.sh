#!/bin/bash

# check dependencies`
echo "----- Start Installation -----"
python --version &> .dependency1
pip --version &> .dependency2
aws --version &> .dependency3

PYTHON=`cat .dependency1`
PIP=`cat .dependency2`
AWS=`cat .dependency3`

rm -f .dependency*
VPY=`echo $PYTHON | awk {'print $1'}`
VPI=`echo $PIP | awk {'print $1'}`
VAW=`echo $AWS | cut -d '/' -f 1`
VALIDATION=0



if [ $VPY == "Python" ]; then
	echo "Python installed"
	if [ $VPI == "pip" ]; then
		echo "Pip installed"
		if [ $VAW == "aws-cli" ];then
			echo "AWS Cli is installed"
			VALIDATION=1
		else
			echo "Installation Error: AWS-CLI not installed"
		fi
	else
		echo "Installation Error: Pip not installed"
	fi
else
	echo "Installation Error: Python not installed"
fi

if [ $VALIDATION == 1 ];then
	chmod +x source/parola-v0.0.1
	cp source/parola-v0.0.1 /bin/parola
	chmod +x /bin/parola
	echo "Running "aws configure" and get the details from AJ"
	aws configure
	if [ -f ~/.ssh/id_rsa.pub ]; then
		./source/parola-v0.0.1 myfirstsetup
	else
		ssh-keygen
		./source/parola-v0.0.1 myfirstsetup
	fi
	echo "----- End of Installation -----"	
else
	echo "----- End of Installation with Errors -----"
fi
