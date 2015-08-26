#!/usr/bin/env bash
echo "1 to create new image 2 to import existing one"
read n
case $n in
   	 1) 
	echo "vm name"
        read VM_NAME
	echo "ram ex 1000"
	read RAM
	echo "Disk path ex /home/vm/test.img"
	read DISK_PATH
	echo "disk size ex. 8 "
	read DISK_SIZE
	echo "bridge ex br0"
        read BRIDGE
	echo "cd path ex. /iso/centos.iso"
	read CD_PATH
	virt-install --name $VM_NAME --ram $RAM --disk path=$DISK_PATH,size=$DISK_SIZE --network bridge=$BRIDGE --vnc --cdrom $CD_PATH
	;;
	 2) 
	echo "vm name"
	read VM_NAME
	echo "ram"
	read RAM
	echo "image path ex. /home/vm/pg.im"
	read IMAGE_PATH
	echo "bridge ex br0"		
	read BRIDGE
	virt-install --connect qemu:///system --name $VM_NAME --ram $RAM --disk path=$IMAGE_PATH, --network bridge:$BRIDGE --accelerate --vnc --import
	;;
    *) echo "invalid option";;
esac
