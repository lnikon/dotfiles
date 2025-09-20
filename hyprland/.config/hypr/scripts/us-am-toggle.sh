#!/bin/bash

set -eufo pipefail

# Get the first non-virtual keyboard name
KEYBOARD=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .name')

if [ -z "$KEYBOARD" ]; then
  echo "No keyboard found"
  exit 1
fi

# Get current layout
CURRENT_LAYOUT=$(hyprctl devices -j | jq --arg KEYBOARD "${KEYBOARD}" -r '.keyboards[] | select(.name == $KEYBOARD) | .active_keymap' | head -n1)

case $CURRENT_LAYOUT in
"English (US)")
  # US (0) -> AM (1)
  hyprctl switchxkblayout "${KEYBOARD}" 1
  notify-send "Layout" "🇦🇲 Armenian" -t 1000
  ;;
"Armenian (phonetic)")
  # AM (1) -> US (0)
  hyprctl switchxkblayout "${KEYBOARD}" 0
  notify-send "Layout" "🇺🇸 English" -t 1000
  ;;
*)
  # If in Russian or other, go to US first
  hyprctl switchxkblayout "${KEYBOARD}" 0
  notify-send "Layout" "🇺🇸 English" -t 1000
  ;;
esac
