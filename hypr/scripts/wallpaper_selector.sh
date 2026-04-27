#!/usr/bin/env bash

CURRENT_STYLE=$(readlink -f ~/.config/waybar/style.css 2>/dev/null || echo "")
CURRENT_BASENAME=$(basename "$CURRENT_STYLE")

if [[ "$CURRENT_BASENAME" == *"-dark.css" ]]; then
    SWITCHTO="-dark"
else
    SWITCHTO=""
fi

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers/themes/images$SWITCHTO"
SYMLINK_PATH="$HOME/.config/hypr/wallpapers/wallpaper.jpg"

cd "$WALLPAPER_DIR" || exit 1

IFS=$'\n'

SELECTED_WALL=$(
    for a in $(ls -t *.jpg *.png *.gif *.jpeg 2>/dev/null); do
        printf '%s\0icon\x1f%s\n' "$a" "$a"
    done | rofi -dmenu -p ""
)

[ -z "$SELECTED_WALL" ] && exit 1

SELECTED_PATH="$WALLPAPER_DIR/$SELECTED_WALL"

ln -sf "$SELECTED_PATH" "$WALLPAPER_DIR/link"
ln -sf "$WALLPAPER_DIR/link" "$SYMLINK_PATH"

pgrep -x awww-daemon >/dev/null || awww-daemon &
sleep 0.2

awww img --transition-type grow --transition-duration 1  "$SYMLINK_PATH"

magick "$SYMLINK_PATH" -resize '1920x1200>' -quality 100 "$HOME/.config/rofi/wallpaper.jpg"
cp "$HOME/.config/rofi/wallpaper.jpg" "$HOME/.config/wlogout/wallpaper.jpg"
magick "$HOME/.config/wlogout/wallpaper.jpg" -blur 0x8 "$HOME/.config/wlogout/wallpaper.jpg"
