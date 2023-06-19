#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Dock\n\n"

execute "gsettings set org.gnome.shell.extensions.dash-to-dock autohide true && \
         gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false" \
    "Autohide the Dock"

execute "gsettings set org.gnome.shell.extensions.dash-to-dock dock-position TOP" \
    "Move Dock to top"

execute "gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false" \
    "Dock centered"
