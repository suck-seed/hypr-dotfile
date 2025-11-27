#!/bin/bash

# Symbolic link, since i am not clutturing my config with unnessery apps and bloat my gitignore augh
ln -s ~/dotfiles/xdg-desktop-portal ~/.config/xdg-desktop-portal
ln -s ~/dotfiles/wlogout ~/.config/wlogout
ln -s ~/dotfiles/waybar ~/.config/waybar
ln -s ~/dotfiles/swaync ~/.config/swaync
ln -s ~/dotfiles/rofi ~/.config/rofi
ln -s ~/dotfiles/pipewire ~/.config/pipewire
ln -s ~/dotfiles/pavucontrol.ini ~/.config/pavucontrol.ini
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/mimeapps.list ~/.config/mimeapps.list
ln -s ~/dotfiles/kitty ~/.config/kitty
ln -s ~/dotfiles/hyprshade ~/.config/hyprshade
ln -s ~/dotfiles/hypr ~/.config/hypr
ln -s ~/dotfiles/ghostty ~/.config/ghostty
ln -s ~/dotfiles/fish ~/.config/fish
ln -s ~/dotfiles/fastfetch ~/.config/fastfetch
ln -s ~/dotfiles/cava ~/.config/cava
ln -s ~/dotfiles/btop ~/.config/btop
ln -s ~/dotfiles/bleachbit ~/.config/bleachbit
ln -s ~/dotfiles/gtk-3.0 ~/.config/gtk-3.0
ln -s ~/dotfiles/gtk-4.0 ~/.config/gtk-4.0


# download packages
# GRAPHICS DRIVERS (IF NOT INSTALLED)
sudo pacman -S mesa vulkan-radeon

# PARU AND YAY
sudo pacman -S paru yay

# HYPRLAND CORE
sudo pacman -S hyprland hyprlock hyprshade hypridle
yay -S dwl

# USED IN WAYBAR
sudo pacman -S waybar cava fastfetch btop
yay -S bongocat

# USED IN TERMINAL
sudo pacman -S fish ghostty

# SOUND
sudo pacman -S pipewire pipewire-pulse wireplumber pavucontrol

# UTILITIES
sudo pacman -S swaync xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland networkmanager network-manager-applet playerctl pamixer brightnessctl udiskie wdisplays hyprpolkitagent wltcl wlogout libnotify ntfs-3g sddm os-prober python

# SCREENSHOT / CLIPBOARD
sudo pacman -S slurp grim wl-clipboard wtype wlroots cliphist

# THEME SWITCHER
sudo pacman -S swww imagemagick jq patch

# ROFI
paru -S rofi-nerdy
sudo pacman -S rofi

# APPLICATIONS (dev)
sudo pacman -S neovim zed obsidian zen-browser git go docker docker-compose lazygit lazydocker
yay -S spotify helium-browser-bin

# APPLICATION GAME
sudo pacman -S steam

# FONTS
sudo pacman -S inter-font
yay -S apple-fonts

# APPLICATION GNOME (love gnome apps)
sudo pacman -S nwg-look gtk3 gtk4 gsettings-desktop-schemas adwaita adwaita-icon-theme dconf glib2 adwaita-cursors loupe papers file-roller gnome-text-editor

# BATTERY CARE
sudo pacman -S asusctl
asusctl -c 80 ## limit to 80%
# disable power-profile-daemon
sudo systemctl mask power-profiles-daemon
sudo systemctl disable --now power-profiles-daemon
yay -S auto-cpufreq
sudo auto-cpufreq --install


# Permissions
chmod +x ~/dotfiles/hypr/scripts/*
chmod +x ~/dotfiles/rofi/launcher.sh
chmod +x ~/dotfiles/rofi/wallpapers.sh
chmod +x ~/dotfiles/waybar/scripts/*


# ENABLE SYSTEM SERVICES
sudo systemctl enable sddm.service

# WATCH CONFIGS
bongocat --watch-config
sudo usermod -a -G input $USER
sudo usermod -aG docker $USER




#  ~/.venvs/waybar-weather/bin/python ~/.config/waybar/scripts/waybar-wttr.py
# 2025-11-25 21:51:31 ~/.venvs/waybar-weather/bin/python ~/dotfiles/waybar/scripts/waybar-wttr.py
# 2025-11-25 21:50:19 nvim dotfiles/waybar/config.jsonc
# 2025-11-25 21:50:11 nvim .config/fish/config.fish
# 2025-11-25 21:49:28 ~/.venvs/waybar-weather/bin/python ~/.config/waybar/scripts/weather.py
# 2025-11-25 21:48:57 pip install requests environs
# 2025-11-25 21:48:52 source ~/.venvs/waybar-weather/bin/activate.fish
# 2025-11-25 21:48:44 python -m venv ~/.venvs/waybar-weather
# 2025-11-25 21:48:34 cd dotfiles/waybar/scripts/
