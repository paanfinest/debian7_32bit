#!/bin/bash 
# 
#Script Copyright www.fornesia.com # Mod Pa'an Finest 
# ================================================== 

# go to root 
cd 

# disable ipv6 
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6 
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local 

# install wget and curl 
apt-get update;apt-get -y install wget curl; 

# set time GMT +7 
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
 
# set locale 
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config 
service ssh restart 

# set repo 
wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/ForNesiaFreak/FNS_Debian7/fornesia.com/null/sources.list.debian7" 
wget "http://www.dotdeb.org/dotdeb.gpg" 
wget "http://www.webmin.com/jcameron-key.asc" 
cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg 
cat jcameron-key.asc | apt-key add -;rm jcameron-key.asc 


# set repo
wget -O /etc/apt/sources.list "https://raw.github.com/arieonline/autoscript/master/conf/sources.list.debian7"
wget "http://www.dotdeb.org/dotdeb.gpg"
cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg

# remove unused
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;

# update 
apt-get update; apt-get -y upgrade;

# install webserver
apt-get -y install nginx php5-fpm php5-cli

# install essential package
apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs openvpn vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip unrar rsyslog debsums rkhunter
apt-get -y install build-essential

# disable exim
service exim4 stop
sysv-rc-conf exim4 off

# update apt-file
apt-file update

# setting vnstat
vnstat -u -i venet0
service vnstat restart

#touch screenfetch-dev
cd
wget https://github.com/KittyKatt/screenFetch/archive/master.zip
apt-get install -y unzip
unzip master.zip
mv screenFetch-master/screenfetch-dev /usr/bin
cd /usr/bin
mv screenfetch-dev screenfetch
chmod +x /usr/bin/screenfetch
chmod 755 screenfetch
cd
echo "clear" >> .bash_profile
echo "screenfetch" >> .bash_profile
#wget -O screenfetch-dev "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/screenfetch-dev"
#mv screenfetch-dev /usr/bin/screenfetch
#chmod +x /usr/bin/screenfetch
#echo "clear" >> .profile
#echo "screenfetch" >> .profile
echo "clear" >> .bashrc 
echo 'e "                 __   _,--="=--,_   __' >> .bashrc
echo 'e "                /  \."    .-.    "./  \' >> .bashrc
echo 'e "               /  ,/  _   : :   _  \/` \' >> .bashrc
echo 'e "               \  `| /o\  :_:  /o\ |\__/' >> .bashrc
echo 'e "                `-'| :="~` _ `~"=: |' >> .bashrc
echo 'e "                   \`     (_)     `/' >> .bashrc
echo 'e "            .-"-.   \      |      /   .-"-.' >> .bashrc 
echo 'e "      .----{     }--|  /,.-'-.,\  |--{     }----.' >> .bashrc
echo 'e "       )   (_)_)_)  \_/`~-===-~`\_/  (_(_(_)   (' >> .bashrc
echo 'e " (|SELAMAT DATANG DI VPS PHREAKER'S JATENG OFFICIAL|)' >> .bashrc 
 ' >> .bashrc 
 echo 'echo -e "Ketik menu untuk menampilkan daftar perintah"' >> .bashrc 
echo 'echo -e ""' >> .bashrc 

# install webserver 
cd 
rm /etc/nginx/sites-enabled/default 
rm /etc/nginx/sites-available/default 
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/nginx.conf" 
mkdir -p /home/vps/public_html 
echo "<pre>Setup By Pa'an Finest</pre>" > /home/vps/public_html/index.html 
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/paanfinest/debian7_32bit/master/vps.conf" 
service nginx restart 

# install openvpn 
wget -O /etc/openvpn/openvpn.tar "https://raw.github.com/arieonline/autoscript/master/conf/openvpn-debian.tar" cd /etc/openvpn/ tar xf openvpn.tar 
wget -O /etc/openvpn/1194.conf "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/1194.conf" 
service openvpn restart 
sysctl -w net.ipv4.ip_forward=1 
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf 
iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE 
iptables-save > /etc/iptables_yg_baru_dibikin.conf 
wget -O /etc/network/if-up.d/iptables "https://raw.githubusercontent.com/paanfinest/debian7_32bit/master/iptables" 
chmod +x /etc/network/if-up.d/iptables 
service openvpn restart 

#konfigurasi openvpn 
cd /etc/openvpn/ 
wget -O /etc/openvpn/client.ovpn "https://raw.githubusercontent.com/panfinest/debian7_32bit/master/client-1194.conf"
sed -i $MYIP2 /etc/openvpn/client.ovpn; 
cp client.ovpn /home/vps/public_html/ 

# install badvpn 
wget -O /usr/bin/badvpn-udpgw "https://github.com/ForNesiaFreak/FNS/raw/master/sett/badvpn-udpgw" 
if [ "$OS" == "x86_64" ]; then 
wget -O /usr/bin/badvpn-udpgw "https://github.com/ForNesiaFreak/FNS/raw/master/sett/badvpn-udpgw64" 
fi 
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local 
chmod +x /usr/bin/badvpn-udpgw 
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 

# setting port ssh 
# go to root
cd

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# install wget and curl
apt-get update;apt-get -y install wget curl;

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
service ssh restart

# set repo
wget -O /etc/apt/sources.list "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/sources.list.debian7"
wget "http://www.dotdeb.org/dotdeb.gpg"
cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg

# remove unused
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove bind9*;

# update
apt-get update; apt-get -y upgrade;

# install webserver
apt-get -y install nginx php5-fpm php5-cli

# install essential package
apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs openvpn vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip unrar rsyslog debsums rkhunter
apt-get -y install build-essential

# disable exim
service exim4 stop
sysv-rc-conf exim4 off

# update apt-file
apt-file update

# setting vnstat
vnstat -u -i venet0
service vnstat restart

# install screenfetch
cd

#touch screenfetch-dev
cd
wget https://github.com/KittyKatt/screenFetch/archive/master.zip
apt-get install -y unzip
unzip master.zip
mv screenFetch-master/screenfetch-dev /usr/bin
cd /usr/bin
mv screenfetch-dev screenfetch
chmod +x /usr/bin/screenfetch
chmod 755 screenfetch
cd
echo "clear" >> .bash_profile
echo "screenfetch" >> .bash_profile
#wget -O screenfetch-dev "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/screenfetch-dev"
#mv screenfetch-dev /usr/bin/screenfetch
#chmod +x /usr/bin/screenfetch
#echo "clear" >> .profile
#echo "screenfetch" >> .profile

# install webserver
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup by Rizal Hidayat | 081515292117</pre>" > /home/vps/public_html/index.html
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/vps.conf"
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart
service nginx restart

# install openvpn
wget -O /etc/openvpn/openvpn.tar "https://raw.github.com/arieonline/autoscript/master/conf/openvpn-debian.tar"
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/1194.conf "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/1194.conf"
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
wget -O /etc/iptables.up.rules "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/iptables.up.rules"
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
MYIP=`curl -s ifconfig.me`;
MYIP2="s/xxxxxxxxx/$MYIP/g";
sed -i $MYIP2 /etc/iptables.up.rules;
iptables-restore < /etc/iptables.up.rules
service openvpn restart

#konfigurasi openvpn
cd /etc/openvpn/
wget -O /etc/openvpn/1194-client.ovpn "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/client-1194.conf"
sed -i $MYIP2 /etc/openvpn/1194-client.ovpn;
PASS=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 15 | head -n 1`;
useradd -M -s /bin/false soned
echo "soned:$PASS" | chpasswd
echo "soned" > pass.txt
echo "$PASS" >> pass.txt
tar cf client.tar 1194-client.ovpn pass.txt
cp client.tar /home/vps/public_html/

# install badvpn
wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/badvpn-udpgw"
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300

# install mrtg
wget -O /etc/snmp/snmpd.conf "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/snmpd.conf"
wget -O /root/mrtg-mem.sh "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/mrtg-mem.sh"
chmod +x /root/mrtg-mem.sh
cd /etc/snmp/
sed -i 's/TRAPDRUN=no/TRAPDRUN=yes/g' /etc/default/snmpd
service snmpd restart
snmpwalk -v 1 -c public localhost 1.3.6.1.4.1.2021.10.1.3.1
mkdir -p /home/vps/public_html/mrtg
cfgmaker --zero-speed 100000000 --global 'WorkDir: /home/vps/public_html/mrtg' --output /etc/mrtg.cfg public@localhost
curl "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/mrtg.conf" >> /etc/mrtg.cfg
sed -i 's/WorkDir: \/var\/www\/mrtg/# WorkDir: \/var\/www\/mrtg/g' /etc/mrtg.cfg
sed -i 's/# Options\[_\]: growright, bits/Options\[_\]: growright/g' /etc/mrtg.cfg
indexmaker --output=/home/vps/public_html/mrtg/index.html /etc/mrtg.cfg
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
if [ -x /usr/bin/mrtg ] && [ -r /etc/mrtg.cfg ]; then mkdir -p /var/log/mrtg ; env LANG=C /usr/bin/mrtg /etc/mrtg.cfg 2>&1 | tee -a /var/log/mrtg/mrtg.log ; fi
cd

# setting port ssh
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config
service ssh restart

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 109 -p 110"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
service ssh restart
service dropbear restart

# install vnstat gui
cd /home/vps/public_html/
wget http://www.sqweek.com/sqweek/files/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
sed -i 's/eth0/venet0/g' config.php
sed -i "s/\$iface_list = array('venet0', 'sixxs');/\$iface_list = array('venet0');/g" config.php
sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
sed -i 's/Internal/Internet/g' config.php
sed -i '/SixXS IPv6/d' config.php
cd

# install fail2ban
apt-get -y install fail2ban;service fail2ban restart


# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

#install squid3
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/rizal180499/Auto-Installer-VPS/master/conf/squid3.conf"
sed -i $MYIP2 /etc/squid3/squid.conf;
service squid3 restart

# install webmin
cd
wget "http://prdownloads.sourceforge.net/webadmin/webmin_1.670_all.deb"
dpkg --install webmin_1.670_all.deb;
apt-get -y -f install;
rm /root/webmin_1.670_all.deb
service webmin restart
service vnstat restart

# download script 
cd /usr/bin 
wget -O menu "https://raw.githubusercontent.com/paanfinest/debian7_32bit/master/menu.sh" 
wget -O usernew "https://raw.githubusercontent.com/paanfinest/debian7_32bit/master/usernew.sh" wget -O trial "https://raw.githubusercontent.com/paanfinest/debian7_32bit/master/trial.sh" 
wget -O hapus "https://raw.githubusercontent.com/paanfinest/debian7_32bit/master/hapus.sh" 
wget -O cek "https://raw.githubusercontent.com/pqanfinest/debian7_32bit/master/user-login.sh" 
wget -O member "https://raw.githubusercontent.com/paanfinest/debian7_32bit/master/user-list.sh" wget -O resvis "https://raw.githubusercontent.com/paanfinest/debian7_32bit/master/resvis.sh" 
wget -O speedtest "https://raw.githubusercontent.com/ForNesiaFreak/FNS_Debian7/fornesia.com/null/speedtest_cli.py"
wget -O info "https://raw.githubusercontent.com/paanfinest/debian7_32bit/master/info.sh" 
wget -O about "https://raw.githubusercontent.com/paanfinest/debian7_32bit/master/user-expired.sh" 
echo "0 0 * * * root /usr/bin/reboot" > /etc/cron.d/reboot 
echo "* * * * * service dropbear restart" > /etc/cron.d/dropbear 
chmod +x menu 
chmod +x usernew 
chmod +x trial 
chmod +x hapus 
chmod +x cek 
chmod +x member 
chmod +x resvis 
chmod +x speedtest 
chmod +x info 
chmod +x expired

# finishing 
cd 
chown -R www-data:www-data /home/vps/public_html 
service nginx start 
service openvpn restart 
service cron restart 
service ssh restart 
service dropbear restart 
service squid3 restart 
service webmin restart 
rm -rf ~/.bash_history && history -c 
echo "unset HISTFILE" >> /etc/profile 

# info 
clear 
echo "Autoscript Include:" | tee log-install.txt 
echo "===========================================" | tee -a log-install.txt 
echo "" | tee -a log-install.txt 
echo "Service" | tee -a log-install.txt 
echo "-------" | tee -a log-install.txt 
echo "OpenSSH : 22, 143" | tee -a log-install.txt 
echo "Dropbear : 80, 443" | tee -a log-install.txt 
echo "Squid3 : 8080, 3128, 80 (limit to IP SSH)" | tee -a log-install.txt 
echo "OpenVPN : TCP 1194 (client config : http://$MYIP:81/client.ovpn)" | tee -a log-install.txt echo "badvpn : badvpn-udpgw port 7300" | tee -a log-install.txt 
echo "nginx : 81" | tee -a log-install.txt 
echo "" | tee -a log-install.txt 
echo "Script" | tee -a log-install.txt 
echo "------" | tee -a log-install.txt 
echo "menu (Menampilkan daftar perintah yang tersedia)" | tee -a log-install.txt 
echo "usernew (Membuat Akun SSH)" | tee -a log-install.txt 
echo "trial (Membuat Akun Trial)" | tee -a log-install.txt 
echo "hapus (Menghapus Akun SSH)" | tee -a log-install.txt 
echo "cek (Cek User Login)" | tee -a log-install.txt 
echo "member (Cek Member SSH)" | tee -a log-install.txt 
echo "resvis (Restart Service dropbear, webmin, squid3, openvpn dan ssh)" | tee -a log-install.txt 
echo "reboot (Reboot VPS)" | tee -a log-install.txt 
echo "speedtest (Speedtest VPS)" | tee -a log-install.txt 
echo "info (Menampilkan Informasi Sistem)" | tee -a log-install.txt 
echo "expired (Cek User SSH Expired)" | tee -a log-install.txt 
echo "" | tee -a log-install.txt echo "Fitur lain" | tee -a log-install.txt 
echo "----------" | tee -a log-install.txt 
echo "Webmin : http://$MYIP:10000/" | tee -a log-install.txt 
echo "Timezone : Asia/Jakarta (GMT +7)" | tee -a log-install.txt 
echo "IPv6 : [off]" | tee -a log-install.txt 
echo "" | tee -a log-install.txt 
echo "Original Script by Fornesia, Rzengineer & Fawzya" | tee -a log-install.txt echo "Modifi By Pa'an Finest" | tee -a log-install.txt 
echo "" | tee -a log-install.txt 
echo "Log Instalasi --> /root/log-install.txt" | tee -a log-install.txt 
echo "" | tee -a log-install.txt echo "VPS AUTO REBOOT TIAP 12 JAM, SILAHKAN REBOOT VPS ANDA" | tee -a log-install.txt 
echo "" | tee -a log-install.txt echo "===========================================" | tee -a log-install.txt 
cd 
rm -f /root/debian7.sh
