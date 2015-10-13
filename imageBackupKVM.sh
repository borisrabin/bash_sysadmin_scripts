#!/bin/bash

#############
# variables #    
#############


log_date=$(date +"%m-%d-%y")
image_path='/home/vm/'
backup_path='/home/backup/'
sleep_time='3m'
log_path='/var/log/imageBackup/'
vm_names=( trav-dev pg )
vm_images=( baxtersrv2.img pg.img )



echo "Starting backup" > $log_path"image_backup"$log_date.log


for i in "${!vm_names[@]}"
do

	vm_name="${vm_names[$i]}"
	image_name="${vm_images[$i]}"





# Start backup


# SHUTDOWN VM

	virsh shutdown $vm_name
	echo $(date +"%T") " Starting shutdown $vm_name"  >>  $log_path"image_backup"$log_date.log
 
	sleep $sleep_time

# CHECK IF VM IS PROPERLY DOWN 

	vm_state=$( virsh dominfo $vm_name | grep State | awk '{print $2}' )
	echo $(date +"%T") "$vm_name VM state  $vm_state"  >>  $log_path"image_backup"$log_date.log



# IF NOT DOWN FORCE SHUTDOWN 

	if [ $vm_state = "running" ] ; then 
		virsh destroy $vm_name 
		echo $(date +"%T") " $vm_name still runnig forsfully shutting it"  >>  $log_path"image_backup"$log_date.log

	fi
	sleep $sleep_time
# CHECK IF VM IS DOWN 

	vm_state=$( virsh dominfo $vm_name | grep State | awk '{print $2}' )





	if [ $vm_state = "running" ];  then
		echo $(date +"%T") " Could not shutdown $vm_name" >>  $log_path"image_backup"$log_date.log
 

# vm is ready to be copied 
	else 
		if [ ! -d $backup_path$log_date ]
		then
			mkdir $backup_path$log_date
		fi
		echo $(date +"%T") " $vm_name down starting copy" >>  $log_path"image_backup"$log_date.log

		cp $image_path$image_name $backup_path$log_date/
		echo $(date +"%T") " $vm_name backup completed" >>  $log_path"image_backup"$log_date.log

		virsh start $vm_name
		sleep $sleep_time
		vm_state=$( virsh dominfo $vm_name | grep State | awk '{print $2}' )
fi
		if [ $vm_state = "running" ]
		then
			echo $(date +"%T") " $vm_name image started ok" >>  $log_path"image_backup"$log_date.log


		else 
			echo $(date +"%T") " $vm_name NOT RUNNING" >>  $log_path"image_backup"$log_date.log

			mail info@tekyhost.com < 'problems startiing $vm_name'
	


 		fi



done
