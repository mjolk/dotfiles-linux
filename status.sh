#!/bin/zsh

function music() {

  music=$(playerctl metadata)
  parts=(${(ps:\n:)music})
  for i in $parts; do
    echo "part: $parts[$i];\n"
  done

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
artist=""
album=""
title=""
for i in {1..${#parts[@]}}; do
  #echo "partt: ${parts[i]}\n"
  if [ "${parts[i]#*album}" != "$parts[i]" ]; then
    #echo "found album part $parts[i]"
    pp=(${(ps:    :)parts[i]})
    album="${pp[@]: -1}"
    album=${${album%${album##*[^[:blank:]]}}#${${album%${album##*[^[:blank:]]}}%%[^[:blank:]]*}}
  fi
  if [ "${parts[i]#*artist}" != "$parts[i]" ]; then
    #echo "found artist part $parts[i]"
    pp=(${(ps:    :)parts[i]})
    artist="${=${pp[@]: -1}}"
    artist=${${artist%${artist##*[^[:blank:]]}}#${${artist%${artist##*[^[:blank:]]}}%%[^[:blank:]]*}}
  fi
  if [ "${parts[i]#*title}" != "$parts[i]" ]; then
    #echo "found title part $parts[i]"
    pp=(${(ps:    :)parts[i]})
    title="${pp[@]: -1}"
    title=${${title%${title##*[^[:blank:]]}}#${${title%${title##*[^[:blank:]]}}%%[^[:blank:]]*}}
  fi
done
echo "\uf001 $artist $title $now";

}

if [ "$1" = "station" ]; then
  station
else
  mobile
fi
