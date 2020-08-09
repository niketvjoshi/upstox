#!/bin/bash
###Date: 08/2020###
###Author: Niket Joshi###
###Purpose: Debain & RedHat System Hardening Script###

###Variables###
SCRIPT_DIR="/opt/scripts"

###Code###
if [ "$USER" != "root" ];then
	echo -e "\e[31m Need to execute script as root user\e[00m"
	exit
fi

if [ -f /etc/lsb-release ]; then
	if [ ! -f $SCRIPT_DIR/ubuntu.sh ]; then
		echo -e "\e[31m Ubuntu.sh file does not exist\e[00m"
		exit
	else	
		chmod +x $SCRIPT_DIR/ubuntu.sh
		/bin/bash $SCRIPT_DIR/ubuntu.sh
	fi
elif [ -f /etc/redhat-release ]; then	
	if [ ! -f $SCRIPT_DIR/redhat.sh ]; then
		echo -e "\e[31m RedHat.sh file does not exist \e[00m"
		exit
	fi
	chmod +x $SCRIPT_DIR/redhat.sh
      	/bin/bash $SCRIPT_DIR/redhat.sh
else
	echo -e "\e[31m Linux Distro Not Supported\e[00m"
fi
###END###
