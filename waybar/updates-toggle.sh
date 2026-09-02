#!/bin/bash
WIN=$(hyprctl clients -j 2>/dev/null | jq -r '.[] | select(.class=="general-float") | .pid' | head -n1)

if [ -n "$WIN" ]; then
  kill "$WIN"
else
  kitty --class general-float --title general-float -- bash -c 'echo Finding Update... && sleep 2; checkupdates; sudo pacman -Syu; read -rp "Press Enter..."'
fi
