#!/bin/bash

set -euo pipefail

trap "killall waybar" EXIT

while true; do
    waybar &
    inotifywait -e create,modify ~/.config/waybar/config.jsonc ~/.config/waybar/style.css
    killall waybar
done

