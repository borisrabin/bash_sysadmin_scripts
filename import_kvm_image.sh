#!/usr/bin/env bash

VM_NAME=pg              # vm name 
RAM=1024                # ammount of ram 512 1024 and so on
IMAGE_PATH=/home/vm/pg.img   # image path /vm/image.img 
BRIDGE=br0                 # br0

virt-install --connect qemu:///system --name $VM_NAME --ram $RAM --disk path=$IMAGE_PATH, --network bridge:$BRIDGE --accelerate --vnc --import
