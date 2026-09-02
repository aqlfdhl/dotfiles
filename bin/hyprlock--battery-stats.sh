#!/usr/bin/env bash

# Check if battery exists
if [ ! -d /sys/class/power_supply/BAT0 ]; then
    exit 0
fi

# Read capacity and status
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

# Define icons (Nerd Fonts)
battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")
charging_icon="󰂄"

# Select icon based on percentage
icon_index=$((battery_percentage / 10))
battery_icon=${battery_icons[$icon_index]}

# Override icon if charging
if [ "$battery_status" = "Charging" ]; then
    battery_icon="$charging_icon"
fi

# Output formatted string
echo "$battery_percentage% $battery_icon"   
