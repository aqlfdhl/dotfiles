#!/bin/bash

CACHE_FILE="/home/fadhil/.local/bin/spotify-art/hyprlock_spotify_art.jpg"
TIMEOUT=1 # Strict 1-second timeout

# Get URL
url=$(playerctl --player=spotify metadata mpris:artUrl 2>/dev/null)
url=${url#file://}

if [ -z "$url" ]; then
  exit 0
fi

# If URL changed, download new art with timeout
# Check if we already have this URL cached (simple string check)
if [ "$url" != "$(cat /home/fadhil/.local/bin/spotify-art/hyprlock_spotify_url 2>/dev/null)" ]; then
  # Download with strict timeout, background it slightly to avoid hard block if possible,
  # but primarily rely on curl --max-time
  if curl --max-time $TIMEOUT -s "$url" -o "$CACHE_FILE" 2>/dev/null; then
    echo "$url" >/home/fadhil/.local/bin/spotify-art/hyprlock_spotify_url
  else
    # If download fails/times out, fall back to existing cache if it exists
    if [ -f "$CACHE_FILE" ]; then
      echo "$CACHE_FILE"
      exit 0
    fi
  fi
fi

# Output the path (either new or cached)
if [ -f "$CACHE_FILE" ]; then
  echo "$CACHE_FILE"
else
  # Fallback if nothing exists yet
  echo "$url"
fi
