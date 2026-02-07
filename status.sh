#!/bin/zsh

now=$(date +'%D %T');
power=$(cat /sys/class/power_supply/BAT0/capacity);
wifi=$(iwctl station wlan0 show);
parts=(${(@s/ /)wifi})
if [[ $parts[12] = "connected" ]]; then
  wificonnected="\uf1eb  $parts[16]" 
else
  wificonnected="\uf2cc "
fi
test=$'\uf242'
if (( $power < 60 )); then
  powerstr=$'\uf243';
elif (( $power < 40)); then
  powerstr=$'\uf242';
else
  powerstr=$'\uf240';
fi
echo "$wificonnected $powerstr  $now";
