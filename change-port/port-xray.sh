#!/bin/bash
#wget https://github.com/${GitUser}/
GitUser="SandakanVPNTrickster"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
# Valid Script
VALIDITY () {
    today=`date -d "0 days" +"%Y-%m-%d"`
    Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mYOUR SCRIPT ACTIVE..\e[0m"
    else
    echo -e "\e[31mYOUR SCRIPT HAS EXPIRED!\e[0m";
    echo -e "\e[31mPlease renew your ipvps first\e[0m"
    exit 0
fi
}
IZIN=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | awk '{print $5}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPermission Accepted...\e[0m"
VALIDITY
else
echo -e "\e[31mPermission Denied!\e[0m";
echo -e "\e[31mPlease buy script first\e[0m"
exit 0
fi
clear
vmess="$(cat ~/log-install.txt | grep -w "Vmess Grpc Tls" | cut -d: -f2|sed 's/ //g')"
vless="$(cat ~/log-install.txt | grep -w "Vless Grpc Tls" | cut -d: -f2|sed 's/ //g')"
xtls="$(cat ~/log-install.txt | grep -w "Vless Tcp Xtls" | cut -d: -f2|sed 's/ //g')"
tls="$(cat ~/log-install.txt | grep -w "Vmess Ws Tls" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess Ws None Tls" | cut -d: -f2|sed 's/ //g')"
tlsv1="$(cat ~/log-install.txt | grep -w "Vless Ws Tls" | cut -d: -f2|sed 's/ //g')"
nonev1="$(cat ~/log-install.txt | grep -w "Vless Ws None Tls" | cut -d: -f2|sed 's/ //g')"
echo -e "\e[0;34m.-----------------------------------------.\e[0m"
echo -e "\e[0;34m|             \e[1;33mCHANGE PORT XRAY\e[m            \e[0;34m|\e[0m"
echo -e "\e[0;34m'-----------------------------------------'\e[0m"
echo -e " \e[1;31m>>\e[0m\e[0;32mChange Port For Xray :\e[0m"
echo -e "  [1]  Change Port Xray Vmess Grpc Tls $vmess"
echo -e "  [2]  Change Port Xray Vless Grpc Tls $vless"
echo -e "  [3]  Change Port Xray Vless Xtls $xtls"
echo -e "  [4]  Change Port Xray Vmess WS TLS $tls"
echo -e "  [5]  Change Port Xray Vmess WS None TLS $none"
echo -e "  [6]  Change Port Xray Vless WS TLS $tlsv1"
echo -e "  [7]  Change Port Xray Vless WS None TLS $nonev1"
echo -e "========================================"
echo -e "  [x]  Back To Menu Change Port"
echo -e "  [y]  Go To Main Menu"
echo -e ""
read -p "   Select From Options [1-7 or x & y] :  " prot
echo -e ""
case $prot in
1)
read -p "New Port Xray Vmess Grpc: " tls1
if [ -z $tls1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $tls1)
if [[ -z $cek ]]; then
sed -i "s/$vmess/$tls1/g" /usr/local/etc/xray/config.json
sed -i "s/   - Xray Vmess Grpc Tls     : $vmess/   - Xray Vmess Grpc Tls     : $tls1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $vmess -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $vmess -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tls1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tls1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray > /dev/null
echo -e "\e[032;1mPort $tls1 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $tls1 is used\e[0m"
fi
;;
2)
read -p "New Port Xray Vless Grpc: " none1
if [ -z $none1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $none1)
if [[ -z $cek ]]; then
sed -i "s/$vless/$tls1/g" /usr/local/etc/xray/vless.json
sed -i "s/   - Xray Vless Grpc Tls     : $vless/   - Xray Vless Grpc Tls     : $none1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $vless -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $vless -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $none1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $none1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray@vless > /dev/null
echo -e "\e[032;1mPort $none1 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $none1 is used\e[0m"
fi
;;
3)
read -p "New Port Xray Vless Xtls: " none1
if [ -z $none1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $none1)
if [[ -z $cek ]]; then
sed -i "s/$xtls/$none1/g" /usr/local/etc/xray/xtls.json
sed -i "s/   - Xray Vless Tcp Xtls     : $xtls/   - Xray Vless Tcp Xtls     : $none1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $xtls -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $xtls -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $none1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $none1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray@xtls > /dev/null
echo -e "\e[032;1mPort $none1 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $none1 is used\e[0m"
fi
;;
4)
read -p "New Port Xray Vmess WS TLS: " tls1
if [ -z $tls1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $tls1)
if [[ -z $cek ]]; then
sed -i "s/$tls/$tls1/g" /usr/local/etc/xray/vmessws.json
sed -i "s/   - Xray Vmess Ws Tls       : $tls/   - Xray Vmess Ws Tls       : $tls1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $tls -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $tls -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tls1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tls1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray@vmessws > /dev/null
echo -e "\e[032;1mPort $tls1 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $tls1 is used\e[0m"
fi
;;
5)
echo "Input Only 2 Character (example : 69,89)"
read -p "New Port Xray Vmess WS None TLS: " none1
if [ -z $none1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $none1)
if [[ -z $cek ]]; then
sed -i "s/$none/$none1/g" /usr/local/etc/xray/none.json
sed -i "s/   - Xray Vmess Ws None Tls  : $none/   - Xray Vmess Ws None Tls  : $none1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $none -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $none -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $none1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $none1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray@none > /dev/null
echo -e "\e[032;1mPort $none1 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $none1 is used\e[0m"
fi
;;
6)
read -p "New Port Xray Vless WS TLS: " tls1
if [ -z $tls1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $tls1)
if [[ -z $cek ]]; then
sed -i "s/$tlsv1/$tls1/g" /usr/local/etc/xray/vlessws.json
sed -i "s/   - Xray Vless Ws Tls       : $tlsv1/   - Xray Vless Ws Tls       : $tls1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $tlsv1 -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $tlsv1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tls1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tls1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray@vlessws > /dev/null
echo -e "\e[032;1mPort $tls1 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $tls1 is used\e[0m"
fi
;;
4)
read -p "New Port Xray Vless WS None TLS: " none1
if [ -z $none1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $none1)
if [[ -z $cek ]]; then
sed -i "s/$nonev1/$none1/g" /usr/local/etc/xray/vnone.json
sed -i "s/   - Xray Vless Ws None Tls  : $nonev1/   - Xray Vless Ws None Tls  : $none1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $nonev1 -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $nonev1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $none1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $none1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray@vnone > /dev/null
echo -e "\e[032;1mPort $none1 modified successfully\e[0m"
else
echo -e "\e[1;31mPort $none1 is used\e[0m"
fi
;;
x)
clear
change-port
;;
y)
clear
menu
;;
*)
echo "Please enter an correct number"
;;
esac
