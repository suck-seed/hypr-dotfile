#!/bin/bash
set -e


# Symbolic link, since i am not clutturing my config with unnessery apps and bloat my gitignore augh

if ! command -v paru >/dev/null 2>&1; then
  echo "[-] paru not found. Install paru first (on Arch) or use CachyOS."
  exit 1
fi


echo "[*] Creating config symlinks safely..."
link() {
    target="$1"
    link="$2"

    if [ -e "$link" ] || [ -L "$link" ]; then
        rm -rf "$link"
    fi

    ln -s "$target" "$link"
}

link ~/hypr-dotfile/wlogout ~/.config/wlogout
link ~/hypr-dotfile/waybar ~/.config/waybar
link ~/hypr-dotfile/swaync ~/.config/swaync
link ~/hypr-dotfile/rofi ~/.config/rofi
link ~/hypr-dotfile/pipewire ~/.config/pipewire
link ~/hypr-dotfile/pavucontrol.ini ~/.config/pavucontrol.ini
link ~/hypr-dotfile/nvim ~/.config/nvim
link ~/hypr-dotfile/mimeapps.list ~/.config/mimeapps.list
link ~/hypr-dotfile/kitty ~/.config/kitty
link ~/hypr-dotfile/hyprshade ~/.config/hyprshade
link ~/hypr-dotfile/hypr ~/.config/hypr
link ~/hypr-dotfile/ghostty ~/.config/ghostty
link ~/hypr-dotfile/fish ~/.config/fish
link ~/hypr-dotfile/fastfetch ~/.config/fastfetch
link ~/hypr-dotfile/cava ~/.config/cava
link ~/hypr-dotfile/btop ~/.config/btop
link ~/hypr-dotfile/bleachbit ~/.config/bleachbit
link ~/hypr-dotfile/gtk-3.0 ~/.config/gtk-3.0
link ~/hypr-dotfile/gtk-4.0 ~/.config/gtk-4.0

# BASE PACKAGES
sudo pacman -Syy --needed base-devel git mesa vulkan-radeon

# HYPRLAND CORE
sudo pacman -S --needed hyprland hyprlock hyprshade hypridle

# USED IN WAYBAR
sudo pacman -S --needed waybar cava fastfetch btop
paru -S bongocat

# USED IN TERMINAL
sudo pacman -S --needed fish ghostty

# SOUND
sudo pacman -S --needed pipewire pipewire-pulse wireplumber pavucontrol

# UTILITIES
sudo pacman -S --needed swaync xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland networkmanager network-manager-applet playerctl pamixer brightnessctl udiskie wdisplays hyprpolkitagent wltcl wlogout libnotify ntfs-3g sddm os-prober python

# SCREENSHOT / CLIPBOARD
sudo pacman -S --needed slurp grim wl-clipboard wtype cliphist

# THEME SWITCHER
sudo pacman -S --needed swww imagemagick jq patch

# ROFI
paru -S rofi-nerdy
sudo pacman -S rofi

# APPLICATIONS (dev)
sudo pacman -S --needed neovim zed obsidian git go docker docker-compose lazygit lazydocker
paru -S spotify helium-browser-bin zen-browser-bin

# APPLICATION GAME
sudo pacman -S steam

# FONTS
sudo pacman -S --needed inter-font
paru -S apple-fonts

# APPLICATION GNOME (love gnome apps)
sudo pacman -S --needed nwg-look gtk3 gtk4 gsettings-desktop-schemas adwaita-icon-theme dconf glib2 adwaita-cursors loupe papers file-roller gnome-text-editor

sudo tee /usr/share/xdg-desktop-portal/portals.conf >/dev/null <<EOF
[preferred]
default=hyprland
gtk=gtk
EOF

# BATTERY CARE
sudo pacman -S --needed asusctl
sudo asusctl -c 80 ## limit to 80%
# disable power-profile-daemon
sudo systemctl mask power-profiles-daemon
sudo systemctl disable --now power-profiles-daemon
paru -S auto-cpufreq
# sudo auto-cpufreq --install
# do it later after installing everything


# Permissions
chmod +x ~/hypr-dotfile/hypr/scripts/*
chmod +x ~/hypr-dotfile/rofi/*.sh
chmod +x ~/hypr-dotfile/waybar/scripts/*


# ADD USERS TO GROUPS
sudo usermod -a -G input $USER # for bongocat
sudo usermod -aG docker $USER # docker

# ENABLE SYSTEM SERVICES
sudo systemctl enable sddm.service
sudo systemctl enable NetworkManager.service





#  ~/.venvs/waybar-weather/bin/python ~/.config/waybar/scripts/waybar-wttr.py
# 2025-11-25 21:51:31 ~/.venvs/waybar-weather/bin/python ~/dotfiles/waybar/scripts/waybar-wttr.py
# 2025-11-25 21:50:19 nvim dotfiles/waybar/config.jsonc
# 2025-11-25 21:50:11 nvim .config/fish/config.fish
# 2025-11-25 21:49:28 ~/.venvs/waybar-weather/bin/python ~/.config/waybar/scripts/weather.py
# 2025-11-25 21:48:57 pip install requests environs
# 2025-11-25 21:48:52 source ~/.venvs/waybar-weather/bin/activate.fish
# 2025-11-25 21:48:44 python -m venv ~/.venvs/waybar-weather
# 2025-11-25 21:48:34 cd dotfiles/waybar/scripts/
