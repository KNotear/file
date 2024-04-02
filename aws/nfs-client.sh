#!/bin/bash
yum -y install nfs-utils
mkdir /sharedb
mount -t nfs 192.168.108.100:/nfs-shared /sharedb
echo "192.168.108.100:/nfs-shared /test nfs defaults 0 0" >> /etc/fstab
echo "ec2-metadata -v | cut -d ' ' -f 2" >> /sharedb/list.txt
umount 192.168.108.100:/nfs-shared
rmdir /sharedb
