#!/bin/bash
yum -y install httpd
cd /var/www/html/
wget https://github.com/KNotear/file/raw/main/project/web.tar
tar -xvf web.tar
availability_zone=$(ec2-metadata -z | cut -d ' ' -f 2)
cat <<EOF > /var/www/html/index.html
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title></title>
		<meta name="keywords" content="">
		<meta name="robots" content="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">
		<meta name="description" content="">
		<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900%7CQuicksand:400,700%7CQuestrial" rel="stylesheet">
		<link href="default.css" rel="stylesheet" type="text/css" media="all">
		<link href="fonts.css" rel="stylesheet" type="text/css" media="all">
	</head>
	<body>
		<div id="header-wrapper">
			<div id="header" class="container">
				<div id="logo">
					<span class="icon icon-cog"></span>
					<h1>준비중입니다.</h1>
					<h2>가용영역:${availability_zone}</h2>
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
	</body>
</html>
EOF
systemctl start httpd
systemctl enable httpd
