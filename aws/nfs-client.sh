#!/bin/bash
yum -y install nfs-utils
mkdir /sharedb
mount -t nfs xxx.xxx.xxx.xxx:/nfs-shared /sharedb
echo "xxx.xxx.xxx.xxx:/nfs-shared /test nfs defaults 0 0" >> /etc/fstab
echo "ec2-metadata -v | cut -d ' ' -f 2" >> /sharedb/list.txt
umount xxx.xxx.xxx.xxx:/nfs-shared
rmdir /sharedb
