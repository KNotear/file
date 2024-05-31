#!/bin/bash
yum -y install java
wget https://github.com/KNotear/file/raw/main/project/apache-tomcat-10.1.24.tar.gz
tar xzf apache-tomcat-10.1.24.tar.gz
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
wget https://github.com/KNotear/file/raw/main/project/mysql-connector-java-8.0.30.jar
cd /apache-tomcat-10.1.24/webapps/ROOT/
wget https://github.com/KNotear/file/raw/main/project/web.tar
tar -xvf web.tar
cat <<EOF > /apache-tomcat-10.1.24/webapps/ROOT/db.jsp
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<meta charset="UTF-8">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title></title>
		<meta name="keywords" content="">
		<meta name="robots" content="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">
		<meta name="description" content="">
		<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900%7CQuicksand:400,700%7CQuestrial" rel="stylesheet">
		<link href="./default.css" rel="stylesheet" type="text/css" media="all">
		<link href="./fonts.css" rel="stylesheet" type="text/css" media="all">
	</head>
	<body>
		<div id="header-wrapper">
			<div id="header" class="container">
				<div id="logo">
					<span class="icon icon-cog"></span>
					<h1><a onClick='history.back()'>MMR-CLOUD</a></h1>
				</div>
			<div id="menu">
				<ul><li class="active">
					<%
						String DB_URL = "jdbc:mysql://mmr-db-cp.clmuc2kwupio.ap-northeast-2.rds.amazonaws.com/test_db";
						String DB_USER = "admin";
						String DB_PASSWORD= "password";
						Connection conn;
						Statement stmt;
						ResultSet rs = null;
						String query = "select * from mmr_team";
			
						try {
							Class.forName("com.mysql.jdbc.Driver");
							conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
							stmt = conn.createStatement();
							rs = stmt.executeQuery(query);
							while (rs.next()) {
								out.println("<li><a onClick='history.back()'>");
								out.println(rs.getString(2));
								out.println("</a></li>");
							}
							rs.close();
							stmt.close();
							conn.close();
						}
						catch(Exception e){
							out.println("Exception Error...");
							out.println("<br>");
							out.println(e.toString());
						}
						finally {
						}
					%>
				</ul>
			</div>
			</div>
			<div class="wrapper">
				<div id="banner" class="container"><img src="images/banner.jpg" width="1200" height="500" alt=""></div>
				<div id="welcome" class="container">
					<div class="title">
						<h2>현재페이지는 업데이트 중입니다.</h2>
						<h3> 빠른 시일내에 서비스를 제공할 수 있도록 노력하겠습니다.</h3>
					</div>
				</div>
			</div>
		</div>
		<div class="copyright">
			<p>Made with: <a>MMR-CLOUD</a></p>
		</div>
	</body>
</html>
EOF
systemctl daemon-reload
systemctl start tomcat
systemctl enable tomcat
