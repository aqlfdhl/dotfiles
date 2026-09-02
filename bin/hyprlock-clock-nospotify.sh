#!/bin/bash
# hyprlock-clock-nospotify.sh
# Outputs the current time ONLY when Spotify is idle/stopped/not running.
# When empty, the label at the "centered" position is invisible.
# Install: cp this to ~/.local/bin/ and chmod +x it.

SPOTIFY_STATUS=$(playerctl -p spotify status 2>/dev/null)

if [[ "$SPOTIFY_STATUS" != "Playing" && "$SPOTIFY_STATUS" != "Paused" ]]; then
    date +"%H:%M"
fi
