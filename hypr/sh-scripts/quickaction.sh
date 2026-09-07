#!/bin/bash
# Menu Option list
options=" Lock\n󰍃 Logout\n Sleep\n Reboot\n Shutdown"

# Uptime
UPTIME="󰅐 $(uptime -p | sed 's/up //')"

# Show menu and pick options
CHOSEN=$(echo -e "$options" |
  rofi -dmenu -i \
    -p "Quick Action:" \
    -mesg "$UPTIME" \
    -theme ~/.config/rofi/horizontal.rasi \
    -theme-str '
        * {
            font: "Hack Nerd Font 24";
        }
        window {
            width: 60%;
            location: north;
            y-offset: 20px;
        }
        inputbar {
            enabled: false;
        }
        message {
            padding: 0px 0px;
        }
        textbox {
            horizontal-align: 0.5;
            font: "Hack Nerd Font 16";
        }
        listview {
            columns: 5;
            lines: 1;
            fixed-columns: true;
        }
        element {
            orientation: horizontal;
            children: [ element-text ];
        }
        element-text {
            horizontal-align: 0.5;
        }
')
# Execute
case $CHOSEN in
" Lock")
  hyprlock
  ;;
"󰍃 Logout")
  command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'
  ;;
" Sleep")
  systemctl suspend
  ;;
" Reboot")
  systemctl reboot
  ;;
" Shutdown")
  systemctl poweroff
  ;;
esac
