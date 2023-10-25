#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   BashScripts\n\n"

declare -r BASH_SCRIPTS_DIRECTORY="$HOME/Documents/projects/bash_scripts/"

download_phpdock() {
    execute "git clone https://github.com/sotiriskast/bash_scripts.git $BASH_SCRIPTS_DIRECTORY" \
        "Download phpdock"
}

if [ ! -d "$BASH_SCRIPTS_DIRECTORY" ]; then
    download_phpdock
fi
