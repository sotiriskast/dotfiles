#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   UI & UX\n\n"

execute "gsettings --schemadir ~/.local/share/gnome-shell/extensions/caffeine@patapon.info/schemas/ get org.gnome.shell.extensions.caffeine toggle-state" \
    "get caffeine"
execute "gsettings --schemadir ~/.local/share/gnome-shell/extensions/caffeine@patapon.info/schemas/ set org.gnome.shell.extensions.caffeine toggle-state true" \
    "Enable Caffeine"
execute "gsettings set org.gnome.desktop.background picture-options 'stretched'" \
    "Set desktop background image options"
execute "gsettings set com.canonical.Unity.Lenses remote-content-search 'none'" \
    "Turn off 'Remote Search' so that search terms in Dash do not get sent over the internet"
