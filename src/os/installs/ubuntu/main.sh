#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Installs\n\n"

update
upgrade

./build-essentials.sh
./git.sh
./browsers.sh
./../nvm.sh
./image_tools.sh
./misc.sh
./misc_tools.sh
./../npm.sh
./tmux.sh
./../vim.sh
./docker.sh
./phpdock.sh
./bash-scripts.sh
./android.sh
./flutter.sh
./dbeaver.sh
./discord.sh


./cleanup.sh
