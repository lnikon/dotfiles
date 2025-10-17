#!/bin/bash

set -eufo pipefail

# Get the first non-virtual keyboard name
# KEYBOARD=$(hyprctl devices -j | jq -r '.keyboards[] | select(.name != "virtual") | .name' | head -n1)
KEYBOARD="rdmctmzt-epomaker-p87"

if [ -z "$KEYBOARD" ]; then
  echo "No keyboard found"
  exit 1
fi

# Get current layout index
CURRENT_LAYOUT=$(hyprctl devices -j | jq -r '.keyboards[] | select(.name != "virtual") | .active_keymap' | head -n1)

case $CURRENT_LAYOUT in
"English (US)")
  # US (0) -> RU (2)
  hyprctl switchxkblayout "$KEYBOARD" 2
  notify-send "Layout" "Switched to Russian" -t 1000
  ;;
"Russian")
  # RU (2) -> US (0)
  hyprctl switchxkblayout "$KEYBOARD" 0
  notify-send "Layout" "Switched to English" -t 1000
  ;;
"Armenian (phonetic)")
  # AM (1) -> RU (2)
  hyprctl switchxkblayout "$KEYBOARD" 2
  notify-send "Layout" "Switched to Russian" -t 1000
  ;;
*)
  # Fallback to US
  hyprctl switchxkblayout "$KEYBOARD" 0
  notify-send "Layout" "Switched to English" -t 1000
  ;;
esac
