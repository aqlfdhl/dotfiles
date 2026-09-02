if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Disable greeting
set -U fish_greeting

# Set editor
set -gx EDITOR vim

# Abbreviations
abbr -a fff fetch
abbr -a ff fastfetch
abbr -a zz zsh
abbr -a v nvim
abbr -a vim nvim
abbr -a hyprconf nvim ~/.config/hypr
abbr -a wybrconf nvim ~/.config/waybar

fish_add_path /home/fadhil/.spicetify
