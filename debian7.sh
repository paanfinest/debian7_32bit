#!/bin/bash 
# 
#Script Copyright www.fornesia.com # Mod Pa'an Finest 
# ================================================== 
# 
# initialisasi 
var export DEBIAN_FRONTEND=noninteractive 
OS=`uname -m`; 
MYIP=$(wget -qO- ipv4.icanhazip.com); 
MYIP2="s/xxxxxxxxx/$MYIP/g"; 

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
# install webserver 
apt-get -y install nginx 

# install essential package 
apt-get -y install bmon iftop htop nmap axel nano iptables traceroute sysv-rc-conf dnsutils bc nethogs openvpn vnstat less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip unrar rsyslog debsums rkhunter 
apt-get -y install build-essential 

# disable exim 
service exim4 stop 
sysv-rc-conf exim4 off

# instal neofetch
cd
wget https://github.com/dylanaraps/neofetch/blob/master/neofetch.1'
mv neofetch /usr/bin/neofetch
chmod +x /usr/bin/neofetch
echo "clear" >> .profile

# install neofetch
echo "deb http://dl.bintray.com/dawidd6/neofetch jessie main" | sudo tee -a /etc/apt/sources.list
curl -L "https://bintray.com/user/downloadSubjectPublicKey?username=bintray" -o Release-neofetch.key && sudo apt-key add Release-neofetch.key && rm Release-neofetch.key
apt-get update
apt-get install neofetch
echo "neofetch" >> .profile

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

cd 
# install badvpn 
wget -O /usr/bin/badvpn-udpgw "https://github.com/ForNesiaFreak/FNS/raw/master/sett/badvpn-udpgw" 
if [ "$OS" == "x86_64" ]; then 
wget -O /usr/bin/badvpn-udpgw "https://github.com/ForNesiaFreak/FNS/raw/master/sett/badvpn-udpgw64" 
fi 
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300' /etc/rc.local 
chmod +x /usr/bin/badvpn-udpgw 
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 

cd 
# setting port ssh 
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config 
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config 
service ssh restart 

# install dropbear 
apt-get -y install dropbear 
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear 
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear 
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 443 -p 80"/g' /etc/default/dropbear 
echo "/bin/false" >> /etc/shells 
echo "/usr/sbin/nologin" >> /etc/shells 
service ssh restart 
service dropbear restart 

cd 
# install squid3 
apt-get -y install squid3 
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/paanfinest/debian7_32bit/master/squid3.conf" 
sed -i $MYIP2 /etc/squid3/squid.conf; 
service squid3 restart 

# install webmin 
cd 
wget -O webmin-current.deb "http://www.webmin.com/download/deb/webmin-current.deb" 
dpkg -i --force-all webmin-current.deb; 
apt-get -y -f install; 
rm /root/webmin-current.deb 
service webmin restart 

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
