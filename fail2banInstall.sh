#!/bin/bash
# Sep 18 2015
# Install fail2ban
# very basic fail2ban install
# brtest

# Install epel

# After install you can edit  /etc/fail2ban/jail.conf Add now add all ip you want. Each IP or range IP must be placed here with a space. Ex: 192.168.0.1 192.168.5.0/32"

# check if wget installed
rpm -qa | grep wget 
if [ $? -ne 0 ]
then
	yum install wget -y
fi

# check if epel repo installed if not install it
yum repolist | grep epel
if [ $? -ne 0 ]
then
	wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm 	
	rpm -ivh epel-release-7-5.noarch.rpm
fi

# check if fail2ban already running 

rpm -qa | grep fail2ban
if [ $? -ne 0 ]
then
	yum install fail2ban-firewalld fail2ban-systemd -y
	cat > /etc/fail2ban/jail.local <<EOF
[DEFAULT]
findtime  = 5000
[sshd]
enabled = true
EOF

	cat > /etc/fail2ban/action.d/firewallcmd-ipset.local <<EOF
[Init]
bantime = 10000
EOF

	systemctl enable fail2ban
	systemctl start fail2ban

	fail2ban-client status sshd


else 
	echo " Looks like fail2ban already installed "
	brake 
fi
