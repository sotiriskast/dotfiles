#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   OpenVPN3\n\n"

get_distribution_name() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ $ID == "ubuntu" ]]; then
            case $VERSION_CODENAME in
                "focal") echo "focal" ;;
                "jammy") echo "jammy" ;;
                "noble") echo "noble" ;;
                # Hypothetical codename for Ubuntu 25.04 - replace when known
                "plucky") echo "plucky" ;;
                *)
                    # Check if it's a newer version - allow future versions with a warning
                    if (( $(echo "$VERSION_ID >= 25.04" | bc -l) )); then
                        print_warning "Using newer Ubuntu version: $VERSION_CODENAME"
                        print_warning "This might not be officially supported yet"
                        echo "$VERSION_CODENAME"
                    else
                        print_error "Unsupported Ubuntu version: $VERSION_CODENAME"
                        exit 1
                    fi
                    ;;
            esac
        elif [[ $ID == "debian" ]]; then
            if [[ $VERSION_ID == "12" ]]; then
                echo "bookworm"
            else
                print_error "Unsupported Debian version: $VERSION_ID"
                exit 1
            fi
        else
            print_error "Unsupported distribution: $ID"
            exit 1
        fi
    else
        print_error "Could not determine distribution"
        exit 1
    fi
}

installOpenVPN3() {
    # Update package index
    update

    # Install prerequisites
    execute \
        "sudo apt-get install -y apt-transport-https curl" \
        "Install prerequisites"

    # Create keyrings directory if it doesn't exist
    execute \
        "sudo mkdir -p /etc/apt/keyrings" \
        "Create keyrings directory"

    # Add OpenVPN's official GPG key
    execute \
        "sudo curl -sSfL https://packages.openvpn.net/packages-repo.gpg -o /etc/apt/keyrings/openvpn.asc" \
        "Download OpenVPN's GPG key"

    # Get distribution name
    DISTRIBUTION=$(get_distribution_name)

    # Add the repository to Apt sources
    execute \
        "echo \"deb [signed-by=/etc/apt/keyrings/openvpn.asc] https://packages.openvpn.net/openvpn3/debian ${DISTRIBUTION} main\" | sudo tee /etc/apt/sources.list.d/openvpn3.list > /dev/null" \
        "Add OpenVPN3 repository to apt sources"

    # Update package index again
    update

    # Install OpenVPN3
    install_package "OpenVPN3" "openvpn3"

    print_success "OpenVPN3 has been installed successfully"
    print_info "To check installation, run: openvpn3 version"
}

if ! command_exists "openvpn3"; then
    installOpenVPN3
else
    print_success "OpenVPN3 is already installed"
    execute "openvpn3 version" "OpenVPN3 version"
fi
