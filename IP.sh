#!/bin/bash

#Check for connection with NordVPN
VPN_CONN='Not Connected'
NORD_VPN=`nordvpn status`
if [[ $NORD_VPN == *"Status: Connected"* ]]; then
  VPN_CONN='Connected'
fi

# Get GEO / IP Data from external source
GEO_IP_DATA_JSON=`curl -s http://ip-api.com/json`

# Extract IP
PUBLIC_IP=`echo ${GEO_IP_DATA_JSON} | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["query"]'`
# Extract country
PUBLIC_COUNTRY=`echo ${GEO_IP_DATA_JSON} | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["country"]'`
# Extract City
PUBLIC_CITY=`echo ${GEO_IP_DATA_JSON} | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["city"]'`

# Notification 
notify-send "Public GEO IP" "<b>VPN:</b> ${VPN_CONN}
<b>Public IP:</b> ${PUBLIC_IP}
<b>Country:</b> ${PUBLIC_COUNTRY}
<b>City:</b> ${PUBLIC_CITY}" --icon="/home/ernst/Pictures/ip.png" 
