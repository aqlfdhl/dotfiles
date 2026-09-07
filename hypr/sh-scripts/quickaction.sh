#!/bin/bash
# Daftar opsi menu
options=" Lock\n󰍃 Logout\n Sleep\n Reboot\n Shutdown"

# Ambil uptime
UPTIME="󰅐 $(uptime -p | sed 's/up //')"

# Menampilkan menu dan mengambil pilihan pengguna
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
# Eksekusi aksi berdasarkan pilihan
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
