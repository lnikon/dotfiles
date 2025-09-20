#!/bin/bash

set -eufo pipefail

KEYBOARD=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .name')

LAYOUT_STATE_FILE="$HOME/.layout_state"

if [ -z "$KEYBOARD" ]; then
  echo "No keyboard found"
  exit 1
fi

CURRENT_LAYOUT=$(hyprctl devices -j | jq --arg KEYBOARD "${KEYBOARD}" -r '.keyboards[] | select(.name == $KEYBOARD) | .active_keymap' | head -n1)

case $CURRENT_LAYOUT in
"English (US)")
  # Save current state and switch to Russian
  echo "us" >"$LAYOUT_STATE_FILE"
  hyprctl switchxkblayout "$KEYBOARD" 2
  notify-send "Layout" "🇷🇺 Russian" -t 1000
  ;;
"Armenian (phonetic)")
  # Save current state and switch to Russian
  echo "am" >"$LAYOUT_STATE_FILE"
  hyprctl switchxkblayout "$KEYBOARD" 2
  notify-send "Layout" "🇷🇺 Russian" -t 1000
  ;;
"Russian (typewriter)")
  # Go back to previous layout
  if [ -f "$LAYOUT_STATE_FILE" ]; then
    PREV_LAYOUT=$(cat "$LAYOUT_STATE_FILE")
    if [ "$PREV_LAYOUT" = "am" ]; then
      hyprctl switchxkblayout "$KEYBOARD" 1
      notify-send "Layout" "🇦🇲 Armenian" -t 1000
    else
      hyprctl switchxkblayout "$KEYBOARD" 0
      notify-send "Layout" "🇺🇸 English" -t 1000
    fi
  else
    hyprctl switchxkblayout "$KEYBOARD" 0
    notify-send "Layout" "🇺🇸 English" -t 1000
  fi
  ;;
esac
