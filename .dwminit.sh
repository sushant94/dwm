#!/bin/bash
xset fp+ /home/sushant/terminusmod-1.9.9 &
xset fp rehash 
feh --bg-scale Pictures/427553.png
while true; do

# Power/Battery Status
STATUS=$( acpi -b | sed 's/.*: \([a-zA-Z]*\),.*/\1/gi' )
BATT=$( acpi -b | sed 's/.*[charging|unknown], \([0-9]*\)%.*/\1/gi' )
DWM_BATTERY="[$BATT]% [$STATUS]";

# Wi-Fi eSSID
wifiessid="$(/sbin/iwconfig 2>/dev/null | grep ESSID | cut -d: -f2)"
wifiawk="$(echo $wifiessid | awk -F',' '{gsub(/"/, "", $1); print $1}')"
DWM_ESSID="$(echo $wifiawk | cut -d' ' -f1)"
# Volume Level
DWM_VOL=$( amixer sget Master | awk -vORS=' ' '/Mono:/ {print($6$4)}' );

# Date and Time
DWM_CLOCK=$( date '+%e %b %Y %a | %k:%M' );

# Overall output command
DWM_STATUS="WiFi: [$DWM_ESSID] | Power: $DWM_BATTERY | Vol: $DWM_VOL | $DWM_CLOCK";
xsetroot -name "$DWM_STATUS";
sleep 60;

done &
#while true; do
    # Log stderror to a file 
    dwm 2> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
#done
