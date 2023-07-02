#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Docker\n\n"

installDocker() {
    execute \
        "sudo apt-get install \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg \
            software-properties-common" \
        "Install packages to allow apt to use a repository over HTTPS"

    execute \
	"sudo install -m 0755 -d /etc/apt/keyrings"

    execute \
        "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg" \
        "Add Docker’s official GPG key"

    execute \
        "sudo chmod a+r /etc/apt/keyrings/docker.gpg" \
        "Verify key"

    execute \
        "sudo add-apt-repository \
        "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
         "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    update

    install_package "Docker" "docker-ce" "docker-ce-cli" "containerd.io" "docker-buildx-plugin" "docker-compose-plugin"

    if [ ! "$(getent group docker)" ]; then
        execute "sudo groupadd docker"
    fi

    execute "sudo usermod -aG docker $USER"
}

if ! package_is_installed "docker-ce"; then
    installDocker
fi
