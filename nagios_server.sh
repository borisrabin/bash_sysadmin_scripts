#!/bin/bash


# FOR firewalld_state remote plugin the following has to be done (defined as firewalld status)
# 1. copy plugin to  /usr/lib64/nagios/plugins/ on client system and chmod +x 
# 2. edit /etc/nagios/nrpe.conf and add plugin  and add below
# command[firewalld_state]=/usr/lib64/nagios/plugins/firewalld_state.sh








# make sure this information is flled up

IP_NG='172.22.4.136'
HOSTNAME_NG='nagiosclient1'
ALIAS_NG='nagiosclient1'
CONTACT_GRP='boris_admins'




cat >/usr/local/nagios/etc/servers/$HOSTNAME_NG.cfg <<EOL


define host{
        use                     linux-server            ; Name of host template to use
							; This host definition will inherit all variables that are defined
							; in (or inherited by) the linux-server host template definition.
        host_name               $HOSTNAME_NG
        alias                   $ALIAS_NG
        address                 $IP_NG
	contact_groups          $CONTACT_GRP
        }


define service{
        use                             local-service         ; Name of service template to use
        host_name                       $HOSTNAME_NG
        service_description             PING
	contact_groups		        $CONTACT_GRP
	check_command			check_ping!100.0,20%!500.0,60%
        }


# Define a service to check the disk space of the root partition
# on the local machine.  Warning if < 20% free, critical if
# < 10% free space on partition.

define service{
        use                             local-service         ; Name of service template to use
        host_name                       $HOSTNAME_NG
        service_description             Root Partition
	contact_groups		        $CONTACT_GRP
	check_command			check_local_disk!20%!10%!/
        }

# Define a service to check the number of currently logged in
# users on the local machine.  Warning if > 20 users, critical
# if > 50 users.

define service{
        use                             local-service         ; Name of service template to use
        host_name                       $HOSTNAME_NG
        service_description             Current Users
	contact_groups		        $CONTACT_GRP
	check_command			check_local_users!20!50
        }


# Define a service to check the number of currently running procs
# on the local machine.  Warning if > 250 processes, critical if
# > 400 users.

define service{
        use                             local-service         ; Name of service template to use
        host_name                       $HOSTNAME_NG
        service_description             Total Processes
	contact_groups		        $CONTACT_GRP
	check_command			check_local_procs!250!400!RSZDT
        }



# Define a service to check the load on the local machine. 

define service{
        use                             local-service         ; Name of service template to use
        host_name                       $HOSTNAME_NG
        service_description             Current Load
	contact_groups		        $CONTACT_GRP
	check_command			check_local_load!5.0,4.0,3.0!10.0,6.0,4.0
        }



# Define a service to check the swap usage the local machine. 
# Critical if less than 10% of swap is free, warning if less than 20% is free

define service{
        use                             local-service         ; Name of service template to use
        host_name                       $HOSTNAME_NG
        service_description             Swap Usage
	contact_groups		        $CONTACT_GRP
	check_command			check_local_swap!20!10
        }



# Define a service to check SSH on the local machine.
# Disable notifications for this service by default, as not all users may have SSH enabled.

define service{
        use                             local-service         ; Name of service template to use
        host_name                       $HOSTNAME_NG
        service_description             SSH
	contact_groups 		        $CONTACT_GRP
	check_command			check_ssh
	notifications_enabled		0
        }
define service{
          use                 generic-service
          host_name           $HOSTNAME_NG
          service_description Firewalld status
          contact_groups      $CONTACT_GRP
          check_command       check_nrpe!firewalld_state
          }



EOL


/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg 

