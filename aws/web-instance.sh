#!/bin/bash
yum -y install httpd
systemctl start httpd
systemctl enable httpd
echo "<h1><font color='blue'> 서울 웹 서버 </font></h1>" > /var/www/html/index.html
