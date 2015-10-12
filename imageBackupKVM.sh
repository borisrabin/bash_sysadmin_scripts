#!/bin/bash

#############
# variables #    
#############
vm_name='trav-dev'
image_name='baxtersrv2.img'
log_date=$(date +"%m-%d-%y")
image_path='/home/vm/'
backup_path='/home/backup/'
sleep_time='3m'

# Start backup
echo "Starting backup" > image_backup$log_date.log



# SHUTDOWN VM

virsh shutdown $vm_name
echo $(date +"%T") " Starting shutdown $vm_name"  >> image_backup$log_date.log 
sleep $sleep_time

# CHECK IF VM IS PROPERLY DOWN 

vm_state=$( virsh dominfo $vm_name | grep State | awk '{print $2}' )
echo $(date +"%T") "$vm_name VM state  $vm_state"  >> image_backup$log_date.log


# IF NOT DOWN FORCE SHUTDOWN 

if [ $vm_state = "running" ] ; then 
virsh destroy $vm_name 
echo $(date +"%T") " $vm_name still runnig forsfully shutting it"  >> image_backup$log_date.log
fi
sleep $sleep_time
# CHECK IF VM IS DOWN 

vm_state=$( virsh dominfo $vm_name | grep State | awk '{print $2}' )

if [ $vm_state = "running" ];  then
	echo $(date +"%T") " Could not shutdown $vm_name" >> image_backup$log_date.log 
else 
	mkdir $backup_path$log_date
	echo $(date +"%T") " $vm_name down starting copy" >> image_backup$log_date.log
	cp $image_path$image_name $backup_path$log_date/
	echo $(date +"%T") " $vm_name backup completed" >> image_backup$log_date.log
	virsh start $vm_name
 fi



# COPY IMAGE 



# START VM 




# CHECK IF VM IS RUNNING 

