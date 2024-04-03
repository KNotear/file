#!/bin/bash
availability_zone=$(ec2-metadata -z | cut -d ' ' -f 2)
instance_id=$(ec2-metadata -i | cut -d ' ' -f 2)
private_ip=$(ec2-metadata -o | cut -d ' ' -f 2)
yum -y install httpd
systemctl start httpd
systemctl enable httpd
cat <<EOF > /var/www/html/index.html
<h1><font color=blue> 상파울루 웹 서버 </font></h1>
<br>
<h2> 가용 영역 : ${availability_zone} </h2>
<br>
<h3> 인스턴스 ID : ${instance_id} </h3>
<br>
<h3> 프라이빗 IP : ${private_ip}</h3>
EOF
