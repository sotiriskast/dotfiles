#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n • Installs\n\n"

update
upgrade

./build-essentials.sh

./git.sh
./../nvm.sh
./browsers.sh
./compression_tools.sh
./image_tools.sh
./misc.sh
./misc_tools.sh
./../npm.sh
./tmux.sh
./../vim.sh
./docker.sh
./phpdock.sh
./android.sh
./flutter.sh
./cleanup.sh
