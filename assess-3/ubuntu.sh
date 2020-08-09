#!/bin/bash
###Date: 08/2020###
###Purpose: Hardening Ubuntu Instance###

###Variables###
hostname=`hostname`
domainname=`hostname -d`
server_ip=`ip r l | awk '{print $9}' | head -1`

###Code & Functions###
login_banner() {
echo -e "\e[34m\e[01m
        Legal Banner \e[00m"
}

if [ "$USER" != "root" ];then
        echo "Need to execute script as root user"
        exit
fi

login_banner > /etc/motd

config_host() {
	echo "$server_ip	$hostname.$domainname	$hostname" >> /etc/hosts	
}

system_update() {
  	echo -e "\e[34m------------------------------------\e[00m"
	echo -e "\e[34m\e[01m Updating Ubuntu System       \e[00m"
  	echo -e "\e[34m------------------------------------\e[00m"
	echo ""
	apt update
	apt upgrade -y	
}

install_fail2ban() {
  	echo -e "\e[34m------------------------------------\e[00m"
	echo -e "\e[34m\e[01m Installing Fail2Ban Service  \e[00m"
  	echo -e "\e[34m------------------------------------\e[00m"
        echo ""
	apt install fail2ban -y
	echo ""
    	echo -e "Done."
}

install_rootkit_hunter() {
  	echo -e "\e[34m-----------------------------------------\e[00m"
	echo -e "\e[34m\e[01m Installing Rootkit Hunter Service \e[00m"
  	echo -e "\e[34m-----------------------------------------\e[00m"
	echo ""
	apt install rkhunter -y		
	rkhunter --update
	echo ""
    	echo -e "Done."
}

install_misc_packages() {
  	echo -e "\e[34m-----------------------------------------\e[00m"
	echo -e "\e[34m\e[01m Installing Rootkit Hunter Service \e[00m"
  	echo -e "\e[34m-----------------------------------------\e[00m"
	echo ""
	apt install tree vim tcptraceroute -y	
	echo ""
    	echo -e "Done."
}

install_acct(){
	echo -e "\e[34m------------------------------------\e[00m"
  	echo -e "\e[93m[+]\e[00m Enable Process Accounting \e[00m"
  	echo -e "\e[34m------------------------------------\e[00m"
  	echo ""
  	apt install acct -y
  	touch /var/log/wtmp
  	echo -e "Done."
}

install_auditd() {
	echo -e "\e[34m---------------------------------\e[00m"
        echo -e "\e[34m\e[01m Installing Auditd Service \e[00m"
        echo -e "\e[34m---------------------------------\e[00m"
	echo ""
	apt install auditd -y
	 echo ""
        echo -e "Done."	
}

install_sysstat() {
	echo -e "\e[34m----------------------------------\e[00m"
        echo -e "\e[34m\e[01m Installing Sysstat Service \e[00m"
        echo -e "\e[34m----------------------------------\e[00m"
	echo ""
	apt install sysstat -y
	sed -i 's/ENABLED="false"/ENABLED="true"/g' /etc/default/sysstat
	echo -e "Done."
}

config_host
system_update
install_fail2ban
install_rootkit_hunter
install_misc_packages
install_acct
install_auditd
install_sysstat
###END###
