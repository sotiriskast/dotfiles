#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Miscellaneous\n\n"

install_package "Transmission" "transmission"
install_package "JSON processor" "jq"
install_package_via_snap "VLC media player" "vlc"
install_package "FileZilla" "filezilla"
install_package_via_snap "PhpStorm" "phpstorm" "--classic"
install_package_via_snap "DBeaver" "dbeaver-ce"
install_package_via_snap "GoLand" "goland" "--classic"
install_package_via_snap "Whatsapp" "whatsapp-electron"
install_package_via_snap "Slack" "slack" "--classic"
install_package_via_snap "Nordvpn" "nordvpn"
install_package_via_snap "Discord" "discord"
install_package_via_snap "Gimp" "gimp"
install_package_via_snap "Signal" "signal-desktop"
install_package_via_snap "Telegram" "telegram-desktop"
install_package_via_snap "Teams" "teams-for-linux"
install_package_via_snap "Insomnia api platform" "insomnia"
install_package "Gpick" "gpick"
install_package "chrome-gnome-shell"
install_package_via_snap "Android Studio" "android-studio" "--classic"
