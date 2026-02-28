#!/bin/zsh

function music() {

  music=$(playerctl metadata)
  parts=(${(ps:\n:)music})
  sparts=(${(ps:  :)parts[4]})
  ssparts=(${(ps:  :)parts[5]})
  sssparts=(${(ps:  :)parts[6]})
  return "$ssparts[2]$sparts[2]$sssparts[2]"

}

function mobile() {

now=$(date +'%d %b %T');
music=$(playerctl metadata)
parts=(${(ps:\n:)music})
sparts=(${(ps:  :)parts[4]})
ssparts=(${(ps:  :)parts[5]})
sssparts=(${(ps:  :)parts[6]})
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
echo "\uf001 $ssparts[2]$sssparts[2]$sparts[2] $wificonnected $powerstr $power% $now \ueeef  ";
}

function station() {

now=$(date +'%d %b %T');
music=$(playerctl metadata)
parts=(${(ps:\n:)music})
sparts=(${(ps:  :)parts[4]})
ssparts=(${(ps:  :)parts[5]})
sssparts=(${(ps:  :)parts[6]})
echo "\uf001 $ssparts[2]$sssparts[2]$sparts[2] $now";

}

if [ "$1" = "station" ]; then
  station
else
  mobile
fi
