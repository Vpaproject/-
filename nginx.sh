OvpnDownload_Port='80'

apt-get update
apt-get upgrade -y
apt-get install nginx

cat <<'EOFnginx' > /etc/nginx/conf.d/bonveio-ovpn-config.conf
server {
 listen 0.0.0.0:85;
 server_name localhost;
 root /var/www/openvpn;
 index index.html;
}
EOFnginx

rm -rf /etc/nginx/sites-*
rm -rf /usr/share/nginx/html
rm -rf /var/www/openvpn
mkdir -p /var/www/openvpn
wget https://raw.githubusercontent.com/GakodArmy/teli/main/index.html
cp index.html /var/www/openvpn

echo -e "[\e[32mInfo\e[0m] Creating OpenVPN client configs.."
 # Setting our nginx config port for .ovpn download site
 sed -i "s|myNginx|$OvpnDownload_Port|g" /etc/nginx/conf.d/bonveio-ovpn-config.conf

 # Removing Default nginx page(port 80)
 rm -rf /etc/nginx/sites-*

 # Creating our root directory for all of our .ovpn configs
 rm -rf /var/www/openvpn
 mkdir -p /var/www/openvpn
 rm /var/www/openvpn/index.html

 # Restarting nginx service
 systemctl restart nginx
cd


