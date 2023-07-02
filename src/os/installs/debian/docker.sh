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
            gnupg \
            curl"\
        "Install packages to allow apt to use a repository over HTTPS"

    execute \
        "sudo install -m 0755 -d /etc/apt/keyrings"\
        "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg" \
        "sudo chmod a+r /etc/apt/keyrings/docker.gpg" \

    execute \
        "echo" \
            "deb [arch='$(dpkg --print-architecture)' signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo '$VERSION_CODENAME') stable" | \
        "sudo tee /etc/apt/sources.list.d/docker.list > /dev/null"

    update

    execute \
            "echo Install Docker Engine"


    install_package "Docker" "docker-ce"

    if [ ! "$(getent group docker)" ]; then
        execute "sudo groupadd docker"
    fi

    execute "sudo usermod -aG docker $USER"
}

if ! package_is_installed "docker-ce"; then
    installDocker
fi

