#!/bin/bash
clear

VAR_UPTIME="$(uptime | sed -E 's/^[^,]*up *//; s/, *[[:digit:]]* user.*//; s/min/minutes/; s/([[:digit:]]+):0?([[:digit:]]+)/\1 hours, \2 minutes/')"
VAR_MEMORY="$(free -m | awk 'NR==2 { printf "%s (Free) / %s (Total)",$4,$2; }')"
VAR_SPACE="$(df -h ~ | awk 'NR==2 { printf "Total: %sB, Used: %sB, Free: %sB",$2,$3,$4; }')"
VAR_LOADAVG="$(uptime |  awk '{printf "%s (1min) %s (5min) %s (15min)", substr($8,0,4),substr($9,0,4),substr($10,0,4); }')"
VAR_USERS_LOGGED="$(who | grep -v localhost | wc -l)"
VAR_PROCESSES="$(ps ax | wc -l | tr -d " ")"
VAR_IP_INTERN="$(hostname -I)"
VAR_IP_EXTERN="$(wget -q -O - http://icanhazip.com/ | tail)"
VAR_TEMP="$(/opt/vc/bin/vcgencmd measure_temp | cut -c "6-9")°C"
VAR_LAST_LOGIN="$(last -i $USER -F | grep -v 'still logged' | head -1 | awk '{print $6,$5,$8,$7}')"
VAR_LAST_LOGIN_IP="$(last -i $USER -F | grep -v 'still logged' | head -1 | awk '{print $3}')"
VAR_DATE="$(date +"%A, %e %B %Y, %R")"
VAR_UNAME="$(uname -snrmo)"


RED=$(tput setaf 1)
GRE=$(tput setaf 2)
YEL=$(tput setaf 3)
BLU=$(tput setaf 4)
CYA=$(tput setaf 6)
WHI=$(tput setaf 7)

echo "${CYA}${VAR_DATE}"
echo "${CYA}${VAR_UNAME}"
echo ""
echo "${GRE}   .~~.   .~~.     ${YEL}Last Login.........:${WHI} ${VAR_LAST_LOGIN} from ${GRE}${VAR_LAST_LOGIN_IP}"
echo "${GRE}  '. \ ' ' / .'    ${YEL}Uptime ............:${WHI} ${VAR_UPTIME}"
echo "${RED}   .~ .~~~..~.     ${YEL}Load Average.......:${WHI} ${VAR_LOADAVG}"
echo "${RED}  : .~.'~'.~. :    ${YEL}Temperature........:${WHI} ${VAR_TEMP}" 
echo "${RED} ~ (   ) (   ) ~   ${YEL}Memory MB..........:${WHI} ${VAR_MEMORY}"
echo "${RED}( : '~'.~.'~' : )  ${YEL}Home Space.........:${WHI} ${VAR_SPACE}" 
echo "${RED} ~ .~ (   ) ~. ~   ${YEL}SSH Logins.........:${WHI} ${VAR_USERS_LOGGED} users logged in"
echo "${RED}  (  : '~' :  )    ${YEL}Running Processes..:${WHI} ${VAR_PROCESSES}"
echo "${RED}   '~ .~~~. ~'     ${YEL}IP Addresses.......:${WHI} ${VAR_IP_INTERN}(${VAR_IP_EXTERN})"
echo "${RED}       '~'         "
echo ""
