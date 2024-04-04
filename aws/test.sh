#!/bin/bash
printf "Left IP(CGW IP)는 ?"
read cgwip
printf "Right IP(TGW IP)는 ?"
read tgwip


cat <<EOF > /root/aws.conf
conn Tunnel1
	authby=secret
	auto=start
	left=%defaultroute
	leftid="$cgwip"
	right="$tgwip"
	type=tunnel
	ikelifetime=8h
	keylife=1h
	phase2alg=aes128-sha1;modp1024
	ike=aes128-sha1;modp1024
	keyingtries=%forever
	keyexchange=ike
	leftsubnet=10.60.0.0/16
	rightsubnet=10.50.0.0/16
	dpddelay=10
	dpdtimeout=30
	dpdaction=restart_by_peer
