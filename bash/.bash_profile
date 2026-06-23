# Load OS-specific configuration
case "$(uname -s)" in
  Darwin)
    [ -f "$DOTFILES/bash/.bash_profile.macos" ] && source "$DOTFILES/bash/.bash_profile.macos"
    ;;
  Linux)
    [ -f "$DOTFILES/bash/.bash_profile.linux" ] && source "$DOTFILES/bash/.bash_profile.linux"
    ;;
esac
