#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   discord\n\n"

download_discord() {
    install_package_via_snap "discord"
}
main() {
    download_discord
}
main
