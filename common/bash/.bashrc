#!/bin/bash
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
export DOTFILES

# Load OS-specific configuration
case "$(uname -s)" in
  Darwin)
    [ -f "$DOTFILES/macos/bash/.bashrc.macos" ] && source "$DOTFILES/macos/bash/.bashrc.macos"
    ;;
  Linux)
    [ -f "$DOTFILES/linux/bash/.bashrc.linux" ] && source "$DOTFILES/linux/bash/.bashrc.linux"
    ;;
esac

# git status cmd prompt
source "$GIT_PROMPT_SH"
GIT_PS1_SHOWUPSTREAM=auto # < behind, > ahead, = up to date
GIT_PS1_SHOWCOLORHINTS=1  # color the branch by state
GIT_BRANCH_GLYPH=$''  # nerd font branch icon (needs a Nerd Font)
PROMPT_COMMAND='__git_ps1 "\[\e[1;36m\]\w\[\e[0m\]" " \\\$ " " '"$GIT_BRANCH_GLYPH"' %s"'


[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

export PATH="$HOME/.local/bin:$PATH"

# aliases
alias beeper="$HOME/app-images/Beeper-4.3.0-x86_64.AppImage --no-sandbox"
alias gti="git"

# For testing
export BASH_RC_LOADED="true"
