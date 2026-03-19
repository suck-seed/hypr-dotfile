#!/bin/bash

ss_dir="$HOME/Pictures/Screenshots/"
date=$(date '+%d-%m-%Y-%H-%M-%S')

selection=$(slurp 2>/dev/null) || exit 0

grim -l 0 -s 1 -g "$selection" "$ss_dir/$date.png"
wl-copy -t image/png < "$ss_dir/$date.png"
notify-send -i "$ss_dir/$date.png" "Grim" "Screenshot saved"
