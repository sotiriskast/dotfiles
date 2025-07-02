#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

setup_1password_git_signing() {

    local os="$(get_os)"
    local gitconfig_local="$HOME/.gitconfig.local"

    print_in_purple "\n • Set up 1Password Git signing\n\n"

    # Only proceed on macOS for now
    if [ "$os" != "macos" ]; then
        print_warning "1Password SSH signing setup is currently only configured for macOS"
        return 1
    fi

    # Check if 1Password is installed and has SSH agent
    if [ ! -f "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" ]; then
        print_error "1Password 8 not found or SSH signing not available"
        print_warning "Please install 1Password 8 and enable SSH agent in Settings → Developer"
        return 1
    fi

    # Check if SSH agent socket exists
    if [ ! -S ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ]; then
        print_error "1Password SSH agent not running"
        print_warning "Please enable SSH agent in 1Password Settings → Developer"
        return 1
    fi

    # Update .gitconfig.local with 1Password SSH signing
    if [ -f "$gitconfig_local" ]; then
        # Backup existing file
        cp "$gitconfig_local" "$gitconfig_local.backup.$(date +%Y%m%d_%H%M%S)"
        print_success "Backed up existing .gitconfig.local"
    fi

    # Read existing user details if available
    local existing_name="$(git config --global user.name 2>/dev/null || echo '')"
    local existing_email="$(git config --global user.email 2>/dev/null || echo '')"

    # Create updated .gitconfig.local
    cat > "$gitconfig_local" << EOF
[commit]
    # Sign commits using GPG/SSH
    gpgsign = true

[user]
    name = $existing_name
    email = $existing_email

[gpg]
    format = ssh

[gpg "ssh"]
    # macOS 1Password 8 SSH signing program
    program = /Applications/1Password.app/Contents/MacOS/op-ssh-sign
EOF

    print_result $? "Update $gitconfig_local"

    # Reload git configuration
    git config --list --local > /dev/null 2>&1

    # Verify setup
    local ssh_program="$(git config --get gpg.ssh.program)"
    if [ "$ssh_program" = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" ]; then
        print_success "Git configured to use 1Password for SSH signing"
    else
        print_error "Git configuration verification failed"
        return 1
    fi
}

check_1password_status() {

    print_in_purple "\n • 1Password SSH Status\n\n"

    # Check 1Password installation
    if [ -d "/Applications/1Password.app" ]; then
        print_success "1Password 8 is installed"
    else
        print_error "1Password 8 not found"
        return 1
    fi

    # Check SSH agent socket
    if [ -S ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ]; then
        print_success "1Password SSH agent is running"
    else
        print_error "1Password SSH agent not found"
        print_warning "Enable SSH agent in 1Password Settings → Developer"
        return 1
    fi

    # Check SSH_AUTH_SOCK
    if [ "$SSH_AUTH_SOCK" = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ]; then
        print_success "SSH_AUTH_SOCK correctly configured"
    else
        print_warning "SSH_AUTH_SOCK not pointing to 1Password"
        print_warning "Current: $SSH_AUTH_SOCK"
        print_warning "Expected: ~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    fi

    # Check Git configuration
    local gpg_format="$(git config --get gpg.format)"
    local ssh_program="$(git config --get gpg.ssh.program)"

    if [ "$gpg_format" = "ssh" ]; then
        print_success "Git configured for SSH signing"
    else
        print_warning "Git not configured for SSH signing (format: $gpg_format)"
    fi

    if [ "$ssh_program" = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" ]; then
        print_success "Git using 1Password for SSH signing"
    else
        print_warning "Git not using 1Password SSH program"
        print_warning "Current: $ssh_program"
    fi

    # Check SSH keys
    print_in_purple "\n   SSH Keys in Agent:\n"
    if ssh-add -l 2>/dev/null; then
        print_success "SSH keys found in agent"
    else
        print_warning "No SSH keys in agent"
        print_warning "Add SSH keys to 1Password or generate new ones"
    fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    case "${1:-setup}" in
        "setup")
            setup_1password_git_signing
            ;;
        "status"|"check")
            check_1password_status
            ;;
        *)
            print_in_purple "\n   1Password SSH Setup\n\n"
            print_warning "Usage: $0 [setup|status]"
            print_warning "  setup  - Configure 1Password SSH signing"
            print_warning "  status - Check 1Password SSH configuration"
            ;;
    esac
}

main "$@"
