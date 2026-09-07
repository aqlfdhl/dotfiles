#!/bin/bash

# Define your wallpaper directory
WALLPAPER_DIR="$HOME/Pictures/Wallpaper"

# Ensure the awww daemon is running
if ! awww query &>/dev/null; then
  awww init
fi

# Generate the list of files for Rofi (displays filenames with image previews)
selected_file=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" -o -name "*.gif" \) | sort | while read -r img; do
  echo -en "$(basename "$img")\0icon\x1f$img\n"
done |
  rofi -dmenu -i \
    -p "Select Wallpaper:" \
    -mesg "Choose Wallpaper" \
    -theme ~/.config/rofi/horizontal.rasi \
    -theme-str '
        window {
            width: 86.4%;
            location: north;
            y-offset: 20px;
        }

        inputbar {
            enabled: false;
        }

        message {
            enabled: true;
            
        }
        textbox {
          horizontal-align: 0.5;
          text-color: @fg2;
        }
        listview {
            layout: horizontal;
            lines: 10;
            fixed-lines: false;
            spacing: 15px;
            expand: true;
        }

        element {
            width: 400px;
            height: 225px;
            padding: 0px;
            orientation: vertical;
        }

        element-text {
            enabled: false;
        }

        element-icon {
            size: 225px;
            width: 400px;
            horizontal-align: 0.5;
            vertical-align: 0.5;
        }
')

# Apply the wallpaper if a selection was made
if [ -n "$selected_file" ]; then
  full_path="$WALLPAPER_DIR/$selected_file"

  # Apply wallpaper with smooth transition effects
  awww img "$full_path" -t center --transition-step 8 --transition-duration 1 --transition-fps 60 && wallust run "$full_path" -s
fi
