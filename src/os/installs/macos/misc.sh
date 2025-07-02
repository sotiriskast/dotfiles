#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Miscellaneous\n\n"

brew_install "Android File Transfer" "android-file-transfer" "--cask"
brew_install "DBeaver community" "dbeaver-community" "--cask"
brew_install "Phpstorm" "phpstorm" "--cask"
brew_install "Microsoft Teams" "microsoft-teams" "--cask"
brew_install "Spotify" "spotify" "--cask"
brew_install "1password" "1password" "--cask"
brew_install "Thunderbird" "thunderbird" "--cask"
brew_install "eyeD3" "eye-d3"
brew_install "Rectangle" "rectangle" "--cask"
brew_install "Unarchiver" "the-unarchiver" "--cask"
brew_install "VLC" "vlc" "--cask"
