#!/bin/bash
mkdir /nfs-shared
chmod 777 /nfs-shared
echo "/nfs-shared 10.0.0.0/14" >> /etc/exports
systemctl restart nfs-server
systemctl enable nfs-server