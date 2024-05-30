#!/bin/bash
yum -y install java
wget http://dlcdn.apache.org/tomcat/tomcat-10/v10.1.24/bin/apache-tomcat-10.1.24.tar.gz
tar xzf apache-tomcat-10.1.24.tar.gz
echo '<%= new java.util.Date()%>' > ./apache-tomcat-10.1.24/webapps/ROOT/test.jsp
echo '[UNIT]' > /usr/lib/systemd/system/tomcat.service
echo 'Description=tomcat' >> /usr/lib/systemd/system/tomcat.service
echo 'After=syslog.target network.target' >> /usr/lib/systemd/system/tomcat.service
echo '[Service]' >> /usr/lib/systemd/system/tomcat.service
echo 'Type=forking' >> /usr/lib/systemd/system/tomcat.service
echo 'ExecStart=/root/apache-tomcat-10.1.24/bin/startup.sh' >> /usr/lib/systemd/system/tomcat.service
echo 'ExecStop=/root/apache-tomcat-10.1.24/bin/shutdown.sh' >> /usr/lib/systemd/system/tomcat.service
echo 'User=root' >> /usr/lib/systemd/system/tomcat.service
echo 'Group=root' >> /usr/lib/systemd/system/tomcat.service
echo '[Install]' >> /usr/lib/systemd/system/tomcat.service
echo 'WantedBy=multi-user.target' >> /usr/lib/systemd/system/tomcat.service
cd ./apache-tomcat-10.1.24/lib/
wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.30/mysql-connector-java-8.0.30.jar
systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat
