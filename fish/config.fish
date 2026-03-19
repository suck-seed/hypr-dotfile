source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

fish_add_path /home/suckseed/.spicetify
fish_add_path /home/suckseed/go/bin

# fnm integration
fnm env --use-on-cd | source

# added for bootdev
set -x PATH $PATH $HOME/go/bin
set -gx PATH $PATH ~/.local/bin
starship init fish | source

fish_add_path /home/nothing/.spicetify
