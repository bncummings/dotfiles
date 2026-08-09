#!/bin/bash

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
export DOTFILES

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

export PATH="$HOME/.local/bin:$PATH"

alias beeper="$HOME/app-images/Beeper-4.3.0-x86_64.AppImage --no-sandbox"

# Load OS-specific configuration
case "$(uname -s)" in
  Darwin)
    [ -f "$DOTFILES/macos/bash/.bashrc.macos" ] && source "$DOTFILES/macos/bash/.bashrc.macos"
    ;;
  Linux)
    [ -f "$DOTFILES/linux/bash/.bashrc.linux" ] && source "$DOTFILES/linux/bash/.bashrc.linux"
    ;;
esac

# For testing
export BASH_RC_LOADED="true"
