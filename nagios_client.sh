#!/bin/bash
# nagios installed from source code on server 
# on client installed using epel repo
# 1. run this script on client 
# 2. run nagios_server.sh on server

# install
yum -y install epel-release
yum -y install nrpe nagios-plugins-all openssl



# modify nrpe to allow access from nagios server 

sed -i.bak s/allowed_hosts=127.0.0.1/'allowed_hosts=127.0.0.1, 172.22.4.52, 38.99.188.12'/g /etc/nagios/nrpe.cfg


# start services
systemctl start nrpe
chkconfig nrpe on
