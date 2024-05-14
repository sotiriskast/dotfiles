#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   dbeaver\n\n"

download_dbeaver() {
    install_package_via_snap "dbeaver-ce"
}
main() {
    download_dbeaver
}

main
