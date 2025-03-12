#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh"

declare -r LOCAL_SHELL_CONFIG_FILE="$HOME/.bash.local"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Flutter\n\n"

declare -r FLUTTER_DIRECTORY="$HOME/Code/flutter"
declare -r FLUTTER_BIN_DIRECTORY="$FLUTTER_DIRECTORY/bin"

install_dependencies() {
    # Install dependencies required for Flutter development
    install_package "Flutter Dependencies" "curl git unzip xz-utils zip libglu1-mesa"

    # For web development
    if ! command_exists "chromium"; then
        install_package_via_snap "Chromium" "chromium"
    fi

    # For Android development
    if [ ! -d "$HOME/Android/Sdk" ]; then
        print_warning "Android SDK not found. Consider installing Android Studio for Android development."
        print_warning "Run: sudo snap install android-studio --classic"
    fi
}

download_flutter() {
    if [ ! -d "$FLUTTER_DIRECTORY" ]; then
        execute "git clone https://github.com/flutter/flutter.git $FLUTTER_DIRECTORY -b stable --depth 1" \
            "Download Flutter SDK"
    else
        print_success "Flutter SDK already exists. Checking for updates..."
        execute "cd $FLUTTER_DIRECTORY && git pull" \
            "Update Flutter SDK"
    fi

    # Pre-download development binaries
    execute "$FLUTTER_BIN_DIRECTORY/flutter precache" \
        "Pre-download development binaries"
}

add_to_path() {
    declare -r -a FILES_TO_PATH=(
        "$FLUTTER_BIN_DIRECTORY"
    )

    # If .bash.local doesn't exist, create it
    if [ ! -f "$LOCAL_SHELL_CONFIG_FILE" ]; then
        execute "touch $LOCAL_SHELL_CONFIG_FILE" \
            "Create local shell config file"
    fi

    # Add Flutter to PATH
    for i in "${FILES_TO_PATH[@]}"; do
        declare CURRENT_PATH="export PATH=\$PATH:$i"
        if ! grep -q "$CURRENT_PATH" "$LOCAL_SHELL_CONFIG_FILE"; then
            execute "printf '%s\n' '$CURRENT_PATH' >> $LOCAL_SHELL_CONFIG_FILE" \
                "$i Added to PATH"
        else
            print_success "$i Already in PATH"
        fi
    done
}

check_flutter() {
    # Source the path to make flutter available in this script session
    if [ -f "$LOCAL_SHELL_CONFIG_FILE" ]; then
        source "$LOCAL_SHELL_CONFIG_FILE"
    fi

    # Run flutter doctor to verify installation
    execute "$FLUTTER_BIN_DIRECTORY/flutter doctor" \
        "Checking Flutter installation"
}

main() {
    install_dependencies
    download_flutter
    add_to_path
    check_flutter

    print_success "Flutter installation completed"
    print_warning "You may need to start a new terminal session for PATH changes to take effect"
}

main
