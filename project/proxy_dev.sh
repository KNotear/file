#!/bin/bash
cat <<EOF >> /etc/httpd/conf/httpd.conf
LoadModule proxy_connect_module modules/mod_proxy_connect.so
LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so

<VirtualHost *:80>
  ProxyRequests On
  ProxyPreserveHost On
  
  <Proxy *>
  Order deny,allow
	Allow from all
	SetEnv force-proxy-request-1.0.1
	SetEnv proxy-nokeepalive 1
	SetEnv proxy-initial-not-pooled 1
  </Proxy>
  ProxyPass "/servlet/" "http://internal-DEV-app-alb-503081101.ap-northeast-2.elb.amazonaws.com:8080" ttl=60
  ProxyPassMAtch "^/.*\.(jsp|do)$" "http://internal-DEV-app-alb-503081101.ap-northeast-2.elb.amazonaws.com:8080/"
  Timeout 120
</VirtualHost>
EOF
systemctl restart httpd
