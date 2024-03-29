#!/bin/bash
sudo yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo "<h1><font color='blue'> 서울 웹 서버 </font></h1>" > /var/www/html/index.html