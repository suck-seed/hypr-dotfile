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
PREVIEW_PATH="$HOME/.config/rofi/wallpaper.jpg"

print_wallpapers() {
    cd "$WALLPAPER_DIR" || exit 1
    IFS=$'\n'
    for file in $(ls -t *.jpg *.png *.gif *.jpeg 2>/dev/null); do
        full_path="$WALLPAPER_DIR/$file"
        printf '%s\0icon\x1f%s\n' "$file" "$full_path"
    done
}

set_wallpaper() {
    local selected="$1"
    [ -z "$selected" ] && exit 0
    local selected_path="$WALLPAPER_DIR/$selected"

    ln -sf "$selected_path" "$WALLPAPER_DIR/link"
    ln -sf "$WALLPAPER_DIR/link" "$SYMLINK_PATH"

    pgrep -x awww-daemon >/dev/null || awww-daemon &
    sleep 0.2

    awww img "$SYMLINK_PATH"

    magick "$SYMLINK_PATH" -resize '2300x1294>' -quality 85 "$PREVIEW_PATH"
    cp "$PREVIEW_PATH" "$HOME/.config/wlogout/wallpaper.jpg"
    magick "$HOME/.config/wlogout/wallpaper.jpg" -blur 0x8 "$HOME/.config/wlogout/wallpaper.jpg"
}

if [ -z "$1" ]; then
    print_wallpapers
    exit 0
fi

set_wallpaper "$1"
