#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   1Password\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! package_is_installed "1password"; then
    print_in_purple "\n   Installing 1Password\n\n"

    # Add the key for the 1Password apt repository
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg \
        || print_error "1Password (adding repository key)"

    # Add the 1Password apt repository
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list \
        || print_error "1Password (adding repository)"

    # Add the debsig-verify policy
    sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/ \
        || print_error "1Password (creating policy directory)"

    curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol \
        || print_error "1Password (adding policy file)"

    sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22 \
        || print_error "1Password (creating keyring directory)"

    curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg \
        || print_error "1Password (adding debsig keyring)"

    # Update package lists and install 1Password
    sudo apt update \
        || print_error "1Password (updating package lists)"

    sudo apt install -y 1password \
        || print_error "1Password (installation)"

    sudo apt install -y 1password-cli \
        || print_error "1password-cli (installation)"

    print_success "1Password installed successfully"
    print_success "1Password installed successfully"
else
    print_success "1Password is already installed"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

printf "\n"
