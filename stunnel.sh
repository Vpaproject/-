#!/bin/bash
clear
if [[ "$EUID" -ne 0 ]]; then
    echo -e "\033[1;31mScript need to be run as root!\033[0m"; exit 1
fi

apt-get -qq update
apt-get -y -qq install stunnel4

cat > /etc/stunnel/stunnel.conf <<-EOF
# pid = /var/run/stunnel4/stunnel.pid
# chroot = /usr/lib/x86_64-linux-gnu/stunnel
# setuid = nobody
# setgid = nogroup
cert = /etc/stunnel/stunnel.pem
client = no

socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear service]
accept = 2021
connect = 127.0.0.1:339

[openvpn service]
accept = 587
connect = 127.0.0.1:4443

# [shadowsocks-libev service]
# accept = 2023
# connect = 127.0.0.1:6561
EOF

# /etc/stunnel/stunnel.conf
# echo 'pid = /var/run/stunnel4/stunnel.pid
# chroot = /usr/lib/x86_64-linux-gnu/stunnel
# setuid = nobody
# setgid = nogroup
# cert = /etc/stunnel/stunnel.pem

# # client = no
# # socket = a:SO_REUSEADDR=1
# # socket = l:TCP_NODELAY=1
# # socket = r:TCP_NODELAY=1

# [dropbear service]
# accept = 2021
# connect = 127.0.0.1:339

# [openvpn service]
# accept = 2022
# connect = 127.0.0.1:587

# [shadowsocks-libev service]
# accept = 2023
# connect = 127.0.0.1:6561' > /etc/stunnel/stunnel.conf

openssl req -new -x509 -days 365 -nodes \
-subj '/C=DO/ST=Dropbear/L=Debian/O="Cybertize"/OU="Cybertize Stunnel"/CN=cybertize.ml' \
-out /etc/stunnel/stunnel.pem -keyout /etc/stunnel/stunnel.pem
openssl dhparam 2048 >> /etc/stunnel/stunnel.pem

# /etc/default/stunnel
echo 'ENABLED=1
FILES="/etc/stunnel/*.conf"
OPTIONS=""
PPP_RESTART=0
RLIMITS="-n 4096"' > /etc/default/stunnel4
systemctl restart stunnel4

echo
echo -e "\033[1;32mTahniah, Kami telah selesai dengan pemasangan stunnel4.\033[0m"
echo
echo 'Use my referral link https://m.do.co/c/a28a40414d6a'
echo 'to gets $100 credit into your DigitalOcean account.'
echo
echo 'Hak Cipta 2021 Doctype, Dikuasakan oleh Cybertize.'
sleep 5
