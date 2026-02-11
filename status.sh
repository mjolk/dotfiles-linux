#!/bin/zsh
function mobile {

now=$(date +'%d %b %T');
power=$(cat /sys/class/power_supply/BAT0/capacity);
wifi=$(iwctl station wlan0 show);
parts=(${(@s/ /)wifi})
wificonnected=""
if [[ $parts[12] = "connected" ]]; then
  wificonnected="\uf0c2  $parts[16]" 
else
  wificonnected="\uebaa "
fi
powerstr=$'\uf240'
if (( $power < 60 )); then
  powerstr=$'\uf242';
fi
if (( $power < 40)); then
  powerstr=$'\uf243';
fi
if (( $power < 20)); then
  powerstr=$'\uf244';
fi
echo "$wificonnected $powerstr $power% $now \ueeef  ";
}

function station {

now=$(date +'%d %b %T');
music=$(mpc current)

echo "\uf001 $music $now";
}

if [ "$1" = "station" ]; then
  station
else
  mobile
fi
