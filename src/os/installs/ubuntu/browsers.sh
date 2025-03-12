#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Browsers\n\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Google Chrome & Chrome Canary using direct download
print_in_purple "\n   Installing Google Chrome\n\n"

# Chrome Stable
if ! package_is_installed "google-chrome-stable"; then
    CHROME_STABLE_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    CHROME_STABLE_DEB="/tmp/google-chrome-stable.deb"

    # Download Chrome Stable
    wget -O "$CHROME_STABLE_DEB" "$CHROME_STABLE_URL" \
        || print_error "Chrome Stable (download)"

    # Install Chrome Stable
    sudo dpkg -i "$CHROME_STABLE_DEB" \
        || print_error "Chrome Stable (install)"

    # Fix any dependency issues
    sudo apt-get install -f -y \
        || print_error "Chrome Stable (dependency fix)"

    # Clean up
    rm -f "$CHROME_STABLE_DEB"

    print_success "Chrome Stable installed successfully"
else
    print_success "Chrome Stable is already installed"
fi

# Chrome Unstable (Canary)
if ! package_is_installed "google-chrome-unstable"; then
    CHROME_UNSTABLE_URL="https://dl.google.com/linux/direct/google-chrome-unstable_current_amd64.deb"
    CHROME_UNSTABLE_DEB="/tmp/google-chrome-unstable.deb"

    # Download Chrome Unstable
    wget -O "$CHROME_UNSTABLE_DEB" "$CHROME_UNSTABLE_URL" \
        || print_error "Chrome Unstable (download)"

    # Install Chrome Unstable
    sudo dpkg -i "$CHROME_UNSTABLE_DEB" \
        || print_error "Chrome Unstable (install)"

    # Fix any dependency issues
    sudo apt-get install -f -y \
        || print_error "Chrome Unstable (dependency fix)"

    # Clean up
    rm -f "$CHROME_UNSTABLE_DEB"

    print_success "Chrome Unstable installed successfully"
else
    print_success "Chrome Unstable is already installed"
fi

# Chromium via Snap
install_package_via_snap "Chromium" "chromium"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

printf "\n"

# Firefox Nightly - using the official Mozilla approach instead of PPA
#if ! command_exists "firefox-nightly"; then
#    print_in_purple "\n   Installing Firefox Nightly\n\n"
#
#    FF_NIGHTLY_URL="https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=en-US"
#    INSTALL_DIR="/opt/firefox-nightly"
#
#    # Create temporary directory for download
#    TMP_DIR=$(mktemp -d)
#
#    # Download Firefox Nightly
#    wget -O "$TMP_DIR/firefox-nightly.tar.bz2" "$FF_NIGHTLY_URL" \
#        || print_error "Firefox Nightly (download)"
#
#    # Remove old installation if exists
#    if [ -d "$INSTALL_DIR" ]; then
#        sudo rm -rf "$INSTALL_DIR"
#    fi
#
#    # Extract to /opt
#    sudo mkdir -p "$INSTALL_DIR"
#    sudo tar xjf "$TMP_DIR/firefox-nightly.tar.bz2" -C "$TMP_DIR"
#    sudo mv "$TMP_DIR/firefox"/* "$INSTALL_DIR"
#
#    # Create desktop entry
#    cat << EOF | sudo tee /usr/share/applications/firefox-nightly.desktop
#[Desktop Entry]
#Name=Firefox Nightly
#GenericName=Web Browser
#Comment=Browse the Web
#Exec=$INSTALL_DIR/firefox %u
#Terminal=false
#Type=Application
#Icon=$INSTALL_DIR/browser/chrome/icons/default/default128.png
#Categories=Network;WebBrowser;
#StartupNotify=true
#EOF
#
#    # Create symbolic link
#    sudo ln -sf "$INSTALL_DIR/firefox" /usr/local/bin/firefox-nightly
#
#    # Clean up temporary directory
#    rm -rf "$TMP_DIR"
#
#    print_success "Firefox Nightly installed successfully"
#else
#    print_success "Firefox Nightly is already installed"
#fi
