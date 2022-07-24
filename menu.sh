#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
echo "Checking VPS"
#########################
GitUser="SandakanVPNTrickster"
# Color Validation
DF='\e[39m'
Bold='\e[1m'
Blink='\e[5m'
yell='\e[36m'
red='\e[31m'
green='\e[32m'
blue='\e[34m'
PURPLE='\e[35m'
cyan='\e[36m'
Lred='\e[91m'
Lgreen='\e[92m'
Lyellow='\e[93m'
NC='\e[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;36m'
LIGHT='\033[0;37m'
# VPS Information
#Domain
domain=$(cat /usr/local/etc/xray/domain)
#Status certificate
modifyTime=$(stat $HOME/.acme.sh/${domain}_ecc/${domain}.key | sed -n '7,6p' | awk '{print $2" "$3" "$4" "$5}')
modifyTime1=$(date +%s -d "${modifyTime}")
currentTime=$(date +%s)
stampDiff=$(expr ${currentTime} - ${modifyTime1})
days=$(expr ${stampDiff} / 86400)
remainingDays=$(expr 90 - ${days})
tlsStatus=${remainingDays}
if [[ ${remainingDays} -le 0 ]]; then
	tlsStatus="expired"
fi
# validity
rm -f /usr/bin/e
valid=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}' )
echo "$valid" > /usr/bin/e

today=`date -d "0 days" +"%Y-%m-%d"`

# CERTIFICATE STATUS
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(( (d1 - d2) / 86400 ))

# USERNAME
rm -f /usr/bin/user
username=$( curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $2}' )
echo "$username" > /usr/bin/user

# DETAIL ORDER
username=$(cat /usr/bin/user)
exp=$(cat /usr/bin/e)

# PROVIDED
creditt=$(cat /root/provided)

# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
#Download/Upload today
dtoday="$(vnstat -i eth0 | grep "today" | awk '{print $2" "substr ($3, 1, 1)}')"
utoday="$(vnstat -i eth0 | grep "today" | awk '{print $5" "substr ($6, 1, 1)}')"
ttoday="$(vnstat -i eth0 | grep "today" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload yesterday
dyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $2" "substr ($3, 1, 1)}')"
uyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $5" "substr ($6, 1, 1)}')"
tyest="$(vnstat -i eth0 | grep "yesterday" | awk '{print $8" "substr ($9, 1, 1)}')"
#Download/Upload current month
dmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $3" "substr ($4, 1, 1)}')"
umon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $6" "substr ($7, 1, 1)}')"
tmon="$(vnstat -i eth0 -m | grep "`date +"%b '%y"`" | awk '{print $9" "substr ($10, 1, 1)}')"
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
IPVPS=$(curl -s ipinfo.io/ip )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )
clear 
echo ""
echo -e "\e[36m                                                            \e[0m"
echo -e "\e[36m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "         • SCRIPT BY SandakanVPNTrickster •"
echo -e "\e[36m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "\e[36m CPU Model            \e[0m: $cname"
echo -e "\e[36m CPU Frequency        \e[0m: $freq MHz"
echo -e "\e[36m Number Of Cores      \e[0m:  $cores"
echo -e "\e[36m CPU Usage            \e[0m:  $cpu_usage"
echo -e "\e[36m Operating System     \e[0m:  "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`	
echo -e "\e[36m Kernel               \e[0m:  `uname -r`"
echo -e "\e[36m Total Amount Of RAM  \e[0m:  $tram MB"
echo -e "\e[36m Used RAM             \e[0m: $red $uram\e[0m MB"
echo -e "\e[36m Free RAM             \e[0m:  $fram MB"
echo -e "\e[36m System Uptime        \e[0m:  $uptime "
echo -e "\e[36m Isp Name             \e[0m:  $ISP"
echo -e "\e[36m Domain               \e[0m:  $domain"	
echo -e "\e[36m Ip Vps               \e[0m:  $IPVPS"	
echo -e "\e[36m City                 \e[0m:  $CITY"
echo -e "\e[36m Time                 \e[0m:  $WKT"
echo -e "\e[36m Day                  \e[0m:  $DAY"
echo -e "\e[36m Date                 \e[0m:  $DATE"
echo -e "\e[36m Telegram             \e[0m:  @SandakanVPNTrickster"
echo -e "\e[36m Script Version       \e[0m:  Version 3.0"
echo -e "\e[36m Certificate status   \e[0m:  Expired in $certifacate days"
echo -e "\e[36m Provided By          \e[0m:  $creditt"
echo -e "\e[36m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[36m Traffic        Today      Yesterday     Month"
echo -e "\e[36m Download      $dtoday $dyest  $dmon"
echo -e "\e[36m Upload        $utoday  $uyest  $umon"
echo -e "\e[36m Total         $ttoday $tyest  $tmon"
echo -e "\e[36m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "             • SCRIPT MENU, DASHBOARD •"
echo -e "\e[36m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " [\e[36m•1\e[0m] SSH & OpenVPN Menu    [\e[36m•7\e[0m] Clear Log"
echo -e " [\e[36m•2\e[0m] Wireguard Menu        [\e[36m•8\e[0m] Status Service"
echo -e " [\e[36m•3\e[0m] SSR & SS Menu         [\e[36m•9\e[0m] Change Port"
echo -e " [\e[36m•4\e[0m] Vmess & Vless Menu    [\e[36m10\e[0m] Add Domain"
echo -e " [\e[36m•5\e[0m] Trojan Menu           [\e[36m11\e[0m] Log Create Config"
echo -e " [\e[36m•6\e[0m] System Menu           [\e[31m12\e[0m] \e[31mREBOOT\033[0m"
echo -e "\e[36m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[36mClient Name    \E[0m: $username"
echo -e " \e[36mScript Expired \E[0m: $exp"
echo -e "\e[36m ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e   ""
echo -e   " Press x or [ Ctrl+C ] • To-Exit-Script"
echo -e   ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
1) clear ; ssh ;;
2) clear ; wgr ;;
3) clear ; ssssr ;;
4) clear ; xraay ;;
5) clear ; trojaan ;;
6) clear ; system ;;
7) clear ; clear-log ;;
8) clear ; check-sc ;;
9) clear ; change-port ;;
10) clear ; add-host ;;
11) clear ; cat /etc/log-create-user.log
       read -n 1 -s -r -p "Press any key to back on menu"
       menu
 ;;
12) clear ; reboot ;;
x) exit ;;
esac
