profile=$(powerprofilesctl get)
case "$profile" in
  performance)  icon="󱐋" ;;
  balanced)     icon="󰾆" ;;
  power-saver)  icon="󰌪" ;;
  *)            icon="?" ;;
esac
echo "$icon  Profile: $profile
󰁹  Battery: $(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)%
   Scroll ↑↓ to change profile"
