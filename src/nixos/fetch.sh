#!/bin/bash

volume_percentage=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F " " '{print $2*100}')
volume_state=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F'[\\[\\]]' 'END{print $2}')
microphone_percentage=$(wpctl get-volume @DEFAULT_SOURCE@ | awk -F " " '{print $2*100}')
microphone_state=$(wpctl get-volume @DEFAULT_SOURCE@ | awk -F'[\\[\\]]' 'END{print $2}')

echo ""
printf "%s %s %s %s %s %s\n" \
"Atenção é a fonte de amor, prazer e paz. Supere o que diminui isso." \
"󰁹 $(cat /sys/class/power_supply/BAT0/capacity)%" \
"  $(date +"%Y-%m-%d %H:%M:%S %A")" \
"$( [ "$volume_state" == "MUTED" ] && printf "%s%s%s\n" " " "$volume_percentage" "%"|| printf "%s%s%s\n" "  " "$volume_percentage" "%")" \
"$( [ "$microphone_state" == "MUTED" ] && printf "%s%s%s\n" " " "$microphone_percentage" "%" || printf "%s%s%s\n" " " "$microphone_percentage" "%")" \
"| $(tmux list-windows -F '#{window_index}#{window_flags}' | awk '{gsub(/\*$/, "*"); printf "%s ", $0} END {print ""}')"
  echo ""
