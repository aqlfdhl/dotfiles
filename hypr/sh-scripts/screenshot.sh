#!/usr/bin/env bash

# Pilihan mode untuk Rofi
CHOSEN=$(printf " Fullscreen\n Window\n󰒅 Region" |
  rofi -dmenu -i \
    -mesg "Screenshot Mode" \
    -theme "$HOME/.config/rofi/horizontal.rasi" \
    -theme-str '
        window {
            width: 35%;
            location: north;
            y-offset: 20px;
        }

        inputbar {
            enabled: false;
        }

        message {
            enabled: true;
            padding: 0px 0px;
        }

        textbox {
            horizontal-align: 0.5;
        }

        listview {
            columns: 3;
            lines: 1;
            fixed-columns: true;
            spacing: 0px;
            padding: 0px;
        }

        element {
            orientation: horizontal;
            children: [ element-text ];
            padding: 8px 0px;
        }

        element-text {
            horizontal-align: 0.5;
        }
')

# Eksekusi Hyprshot berdasarkan pilihan
case "$CHOSEN" in
*Output)
  hyprshot -m output
  ;;
*Window)
  hyprshot -m window
  ;;
*Region)
  hyprshot -m region
  ;;
*)
  exit 1
  ;;
esac
