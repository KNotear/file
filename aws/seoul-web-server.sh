#!/bin/bash
availability_zone=$(ec2-metadata -z)
instance_id=$(ec2-metadata -i)
private_ip=$(ec2-metadata -o)
yum -y install httpd
systemctl start httpd
systemctl enable httpd
cat <<EOF > /var/www/html/index.html
<h1><font color=blue> 서울 웹 서버 </font></h1>
<br>
<h2> ${availability_zone} </h2>
<br>
<h3> ${instance_id} </h3>
<br>
<h3> ${private_ip}</h3>
EOF
