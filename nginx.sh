#!/bin/bash
# OpenVPN Ports
OpenVPN_Port1='1103'
OpenVPN_Port2='25222'
Ohp_Port='7752'
Squid_Port1='8000'
Squid_Port2='3128'
Squid_Port3='60000'
OvpnDownload_Port='85'
MyVPS_Time='Asia/Kuala_Lumpur'
#############################
 apt-get update
 apt-get upgrade -y
 apt-get install nginx 

 # Creating nginx config for our ovpn config downloads webserver
 cat <<'myNginxC' > /etc/nginx/conf.d/bonveio-ovpn-config.conf
# My OpenVPN Config Download Directory
server {
 listen 0.0.0.0:myNginx;
 server_name localhost;
 root /var/www/openvpn;
 index index.html;
}
myNginxC

 # Setting our nginx config port for .ovpn download site
 sed -i "s|myNginx|$OvpnDownload_Port|g" /etc/nginx/conf.d/bonveio-ovpn-config.conf

 # Removing Default nginx page(port 80)
 rm -rf /etc/nginx/sites-*

 # Creating our root directory for all of our .ovpn configs
 rm -rf /var/www/openvpn
 mkdir -p /var/www/openvpn
 # rm /var/www/openvpn/index.html

wget https://raw.githubusercontent.com/89870must73/DEB/main/index.html
cp index.html /var/www/openvpn

# finishing
cd
chown -R www-data:www-data /var/www/openvpn
/etc/init.d/nginx restart
