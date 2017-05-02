#!/bin/bash
#virsh autostart domain
#virsh autostart --disable domain
#virsh list --autostart
#virsh list --all --no-autostart
#from __future__ import print_function


#virsh list --all | awk '{print $2}' | sed '1d' 
vms="$(virsh list --all | awk '{print $2}' | sed '1d'  )"
for l in $vms
 do 
	for g in client1 client2
	do 
        	if [ "$l" == "$g" ]; then
			virsh autostart $g
		
		fi
		
	done 

	if [ "$l" != "client1" ] && [ "$l" != "client2" ]
	then

	virsh autostart --disable $l
	fi
	
	



done


