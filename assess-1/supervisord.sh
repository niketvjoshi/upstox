#!/bin/bash
#Date: 08.2020
#Purpose: Monitor and start process using supervisord daemon
###Functions###
supervisord_install(){
	echo -e "\e[33m Checking for an existing installation of Supervisor Daemon \e[00m"
	/bin/systemctl start supervisor  > /dev/null 2>&1
	if [ "$?" -eq "0" ];then
		echo -e "\e[32m Supervisor is already installed and running \e[00m"
		exit
	else
		echo -e "\e[32m Installing Suppervisord Daemon... \e[00m"
		echo ""
		/usr/bin/hostnamectl | grep "Ubuntu"
		if [ $? -eq "0" ]; then
			apt-get install supervisor -y > /dev/null 2>&1
			echo -e "\e[32m Copying Custom Suppervisord Config File... \e[00m"
			/bin/cp -fv /opt/scripts/assess-1/supervisord.conf /etc/supervisor/supervisord.conf
			/bin/systemctl restart supervisor
			echo -e "\e[32m Supervisor configured and restarted successfully \e[00m"
			echo ""	
			exit
		elif [ -f /etc/redhat-release ]; then	
			/usr/bin/yum install epel-release -y > /dev/null 2>&1
			/usr/bin/yum update > /dev/null 2>&1	
			/usr/bin/yum -y install supervisor > /dev/null 2>&1
			echo -e "\e[32m Copying Custom Suppervisord Config File... \e[00m"
			/bin/cp -fv /opt/scripts/assess-1/supervisord.redhat.conf /etc/supervisord.conf
			/bin/systemctl restart supervisord
			echo -e "\e[32m Supervisor configured and restarted successfully \e[00m"
			echo ""
			exit
		else	
			echo -e "\e[31m Unknown OS... \e[00m"
			echo ""
			exit	
		fi
	fi		
}
supervisord_install
