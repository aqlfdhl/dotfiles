#!/bin/bash

DEVICE="amdgpu_bl1"
MAX_SAFE_RAW=64390
STEP_RAW=3200

case "$1" in
"up")
  current=$(brightnessctl -d "$DEVICE" g)
  new_val=$((current + STEP_RAW))
  if [ "$new_val" -gt "$MAX_SAFE_RAW" ]; then
    new_val=$MAX_SAFE_RAW
  fi
  brightnessctl -d "$DEVICE" set "$new_val"
  # Trigger waybar update
  pkill -RTMIN+1 waybar
  ;;
"down")
  current=$(brightnessctl -d "$DEVICE" g)
  new_val=$((current - STEP_RAW))
  if [ "$new_val" -lt 0 ]; then
    new_val=0
  fi
  brightnessctl -d "$DEVICE" set "$new_val"
  # Trigger waybar update
  pkill -RTMIN+1 waybar
  ;;
"get")
  current=$(brightnessctl -d "$DEVICE" g)
  # Calculate real percentage based on your safe max
  real_pct=$((current * 100 / MAX_SAFE_RAW))

  # VISUAL HACK: Cap displayed percentage at 100 for the icon logic
  display_pct=$real_pct
  if [ "$real_pct" -ge 98 ]; then
    display_pct=100
  fi

  # Output JSON with 'percentage' key for icon selection
  # and 'text' key if you want to show the number separately
  echo "{\"percentage\": $display_pct, \"text\": \"$display_pct\"}"
  ;;
esac

#"on-scroll-up": "~/.config/waybar/scripts/brightness-safe.sh up",
#"on-scroll-down": "~/.config/waybar/scripts/brightness-safe.sh down",
