# Boris Rabin	
# Feb 28 2014 
#
# This script is to configure firewall FW3 on KVM4 br1 and br2 e-pay
################################################
# add ALIAS TO nic facing internet like this
#1. create ifcfg-eth0:1
#2. directives
#DEVICE=eth0:1
#HWADDR=52:54:00:1C:11:72
#TYPE=Ethernet
#UUID=3202bd7a-3773-4fe8-9244-fa90dc231fa2
#ONBOOT=yes
#NM_CONTROLLED=no
#BOOTPROTO=static
#IPADDR=172.22.4.154
#PREFIX=24
#3. network restart
################################################
# To enable routing 
#1. vi /etc/sysctl.conf
#2. net.ipv4.ip_forward = 0  <--- change to 1
################################################
#Filter tables open ports
#iptables -I INPUT -p tcp --dport 49100 -j ACCEPT



####################
# Flush all tables #
####################
#iptables --flush
#iptables --delete-chain
#iptables --table nat --delete-chain
#####################
#  Drop all traffic #
#####################
# iptables -P INPUT DROP
# iptables -P OUTPUT DROP
# iptables -P FORWARD DROP
# iptables -L -v -n
##########################
# Drop incomming traffic #
##########################
# iptables -P INPUT DROP
# iptables -P FORWARD DROP
# iptables -P OUTPUT ACCEPT
# iptables -A INPUT -m state --state NEW,ESTABLISHED -j ACCEPT
# iptables -L -v -n
############################
# Drop IP address          #
############################
# iptables -A OUTPUT -d 75.126.153.206 -j DROP


###################
# VIEW TABLES     #
###################
#iptables -t nat -L 
#iptables -t filter -L 

####################
# General security #
####################
# ICMP Attacks


# SYN Attacks
#iptables -A INPUT -p tcp --syn -m limit --limit 10/s -j ACCEPT
#iptables -A INPUT -p tcp --syn -j DROP
#iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
# NULL packets 
#iptables -A INPIT -p tcp --tcp-flags ALL NONE -j DROP

# Fragment packet 
#iptables -A INPUT -f -j DROP
# TCP Attack
#iptables -A INPUT -p tcp --syn -m limit --limit 10/s -j ACCEPT
#iptables -A INPUT -p tcp --syn –j DROP

#-----------------------NAT---------------------# 

###################
#  SNAT           #
###################

#iptables -t nat -A POSTROUTING -s 172.16.0.0/16 -j SNAT --to 199.68.182.170


###################
# DNAT            #
###################
# ssh access to mail-srv
#iptables -t nat -A PREROUTING -d 199.68.182.170 -p tcp --dport 222 -j DNAT --to 172.16.10.70:222


##################################################
#    Firewall configuration script               #
##################################################

#clean everything
iptables --flush
iptables --delete-chain
iptables --table nat --flush
iptables --delete-chain
iptables --table nat --delete-chain
# drop deny everything accept outgoing
iptables -P INPUT DROP
iptables -P FORWARD DROP
# allow routing from internal interface 
iptables -A FORWARD -i eth1 -j ACCEPT
iptables -A FORWARD -o eth1 -j ACCEPT

# open ssh port to administer
iptables -I INPUT -p tcp --dport 49100 -j ACCEPT
#drop all at the end of input chain
iptables -A INPUT -j DROP
# outgoing snat to allow going out 
iptables -t nat -A POSTROUTING -s 172.16.0.0/16 -j SNAT --to 38.99.188.204
# incomming nat rules

iptables -t nat -A PREROUTING -d 38.99.188.203 -p tcp --dport 80 -j DNAT --to 172.16.10.41:80
iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 80 -j DNAT --to 172.16.10.70:80


iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 222 -j DNAT --to 172.16.10.70:222



iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 25 -j DNAT --to 172.16.10.70:25

iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 3390 -j DNAT --to 172.16.10.30:3390
iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 3391 -j DNAT --to 172.16.10.41:3391
iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 3392 -j DNAT --to 172.16.10.50:3392
iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 3393 -j DNAT --to 172.16.10.63:3393
iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 3394 -j DNAT --to 172.16.10.201:3394
iptables -t nat -A PREROUTING -d 38.99.188.203 -p tcp --dport 443 -j DNAT --to 172.16.10.41:443
iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 3395 -j DNAT --to 172.16.10.202:3395
iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 3396 -j DNAT --to 172.16.10.203:3396
iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 3397 -j DNAT --to 172.16.10.221:3397
iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 49101 -j DNAT --to 172.16.10.10:49101
iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 53 -j DNAT --to 172.16.10.10:53
iptables -t nat -A PREROUTING -d 38.99.188.204 -p udp --dport 53 -j DNAT --to 172.16.10.10:53
iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 443 -j DNAT --to 172.16.10.42:443
iptables -t nat -A PREROUTING -d 38.99.188.202 -p tcp --dport 443 -j DNAT --to 172.16.10.43:443
iptables -t nat -A PREROUTING -d 38.99.188.202 -p tcp --dport 80 -j DNAT --to 172.16.10.43:80
iptables -t nat -A PREROUTING -d 38.99.188.201 -p tcp --dport 443 -j DNAT --to 172.16.10.205:443
iptables -t nat -A PREROUTING -d 38.99.188.201 -p tcp --dport 22 -j DNAT --to 172.16.10.60:22
iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 110 -j DNAT --to 172.16.10.70:110
iptables -t nat -A PREROUTING -d 38.99.188.204 -p tcp --dport 143 -j DNAT --to 172.16.10.70:143
iptables -t nat -A PREROUTING -d 38.99.188.205 -p tcp --dport 80 -j DNAT --to 172.16.10.45:80
iptables -t nat -A PREROUTING -d 38.99.188.205 -p tcp --dport 443 -j DNAT --to 172.16.10.45:443
iptables -t nat -A PREROUTING -d 38.99.188.206 -p tcp --dport 80 -j DNAT --to 172.16.10.44:80
iptables -t nat -A PREROUTING -d 38.99.188.206 -p tcp --dport 443 -j DNAT --to 172.16.10.44:443
iptables -t nat -A PREROUTING -d 38.99.188.200 -p tcp --dport 443 -j DNAT --to 172.16.10.46:443
iptables -t nat -A PREROUTING -d 38.99.188.200 -p tcp --dport 80 -j DNAT --to 172.16.10.46:80


#-----Mailscanner------#
iptables -t nat -A PREROUTING -d 38.99.188.206 -p tcp --dport 25 -j DNAT --to 172.16.10.105:25
iptables -t nat -A PREROUTING -d 38.99.188.206 -p tcp --dport 22 -j DNAT --to 172.16.10.105:22
iptables -t nat -A PREROUTING -d 38.99.188.206 -p tcp --dport 10000 -j DNAT --to 172.16.10.105:10000

iptables -t nat -A PREROUTING -d 38.99.188.201 -p tcp --dport 9000 -j DNAT --to 172.16.10.205:9000
#####################################
# ENABLE LOGING                     #
#####################################
iptables -I INPUT 1 -j LOG
iptables -I FORWARD 1 -j LOG
iptables -I OUTPUT 1 -j LOG
iptables -t nat -I PREROUTING 1 -j LOG
iptables -t nat -I POSTROUTING 1 -j LOG
iptables -t nat -I OUTPUT 1 -j LOG
