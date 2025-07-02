#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../utils.sh" \
    && . "./utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

./xcode.sh
./homebrew.sh
./bash.sh

./git.sh
./../nvm.sh
./browsers.sh
./compression_tools.sh
./gpg.sh
./image_tools.sh
./misc.sh
./misc_tools.sh
./../npm.sh
./tmux.sh
./video_tools.sh
./../vim.sh
./vscode.sh
./web_font_tools.sh
./bash-scripts.sh
./android.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Setup 1Password SSH integration if available
if [ -d "/Applications/1Password.app" ]; then
    print_in_purple "\n   1Password SSH Setup\n\n"

    # Check if SSH agent is enabled
    if [ -S ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ]; then
        ../setup_1password.sh setup
    else
        print_warning "1Password SSH agent not enabled"
        print_warning "To enable: 1Password → Settings → Developer → Use the SSH agent"
        print_warning "Run '../setup_1password.sh setup' after enabling"
    fi
fi
