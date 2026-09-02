#!/bin/bash
# hyprlock-date-nospotify.sh
# Outputs the current date ONLY when Spotify is idle/stopped/not running.
# Install: cp this to ~/.local/bin/ and chmod +x it.

SPOTIFY_STATUS=$(playerctl -p spotify status 2>/dev/null)

if [[ "$SPOTIFY_STATUS" != "Playing" && "$SPOTIFY_STATUS" != "Paused" ]]; then
    date +"%A, %d %B %Y"
fi
