#!/bin/bash
# hyprlock-clock-spotify.sh
# Outputs the current time ONLY when Spotify is Playing or Paused.
# When empty, the label at the "spotify-active" position is invisible.
# Install: cp this to ~/.local/bin/ and chmod +x it.

SPOTIFY_STATUS=$(playerctl -p spotify status 2>/dev/null)

if [[ "$SPOTIFY_STATUS" == "Playing" || "$SPOTIFY_STATUS" == "Paused" ]]; then
    date +"%H:%M"
fi
