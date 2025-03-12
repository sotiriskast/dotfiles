#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Docker\n\n"

installDocker() {
    # Update package index
    update

    # Install prerequisites
    execute \
        "sudo apt-get install -y ca-certificates curl" \
        "Install prerequisites"

    # Add Docker's official GPG key
    execute \
        "sudo install -m 0755 -d /etc/apt/keyrings" \
        "Create keyrings directory"

    execute \
        "sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc" \
        "Download Docker's GPG key"

    execute \
        "sudo chmod a+r /etc/apt/keyrings/docker.asc" \
        "Set permissions for Docker's GPG key"

    # Add the repository to Apt sources
    execute \
        "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"${UBUNTU_CODENAME:-$VERSION_CODENAME}\") stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null" \
        "Add Docker repository to apt sources"

    # Update package index again
    update

    # Install Docker packages
    install_package "Docker Engine" "docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"

    # Add user to docker group to avoid using sudo with docker commands
    if [ ! "$(getent group docker)" ]; then
        execute "sudo groupadd docker" "Create docker group"
    fi

    execute "sudo usermod -aG docker $USER" "Add user to docker group"

    print_warning "Log out and back in for the group changes to take effect, or run: newgrp docker"
}

if ! package_is_installed "docker-ce"; then
    installDocker
else
    print_success "Docker is already installed"
fi
