#!/bin/bash
mkdir /nfs-shared
chmod 777 /nfs-shared
echo "/nfs-shared " >> /etc/exports
systemctl restart nfs-server
systemctl enable nfs-server
