#!/bin/bash
yum -y install openswan

cat <<EOF >> /etc/sysctl.conf
net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
EOF
sysctl -p /etc/sysctl.conf

printf "Left IP(CGW IP) ?"
read cgwip
printf "Right IP(Tunnel1 IP) ?"
read tunnel1ip

cat <<EOF > /etc/ipsec.d/aws.conf 
conn Tunnel1
	authby=secret
	auto=start
	left=%defaultroute
	leftid=$cgwip
	right=$tunnel1ip
	type=tunnel
	ikelifetime=8h
	keylife=1h
	phase2alg=aes128-sha1;modp1024
	ike=aes128-sha1;modp1024
	keyingtries=%forever
	keyexchange=ike
	leftsubnet=10.2.0.0/16
	rightsubnet=10.1.0.0/16
	dpddelay=10
	dpdtimeout=30
	dpdaction=restart_by_peer
EOF

echo "$cgwip $tunnel1ip: PSK "password"" > /etc/ipsec.d/aws.secrets
ipsec start
systemctl enable ipsec.service
