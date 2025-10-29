eval "$(direnv hook bash)"

function tools_linux {
    [[ -f /usr/share/autojump/autojump.sh ]] &&  . /usr/share/autojump/autojump.sh || echo "Autojump not installed"
}

function tools_osx {
     # Cache brew prefix to avoid repeated subprocess calls (50-200ms each)
     local BREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix)}"
     [[ -s "$BREW_PREFIX/etc/autojump.sh" ]] && . "$BREW_PREFIX/etc/autojump.sh"
}

case $os in
Linux)
    tools_linux
    ;;
Darwin)
    tools_osx
    ;;
*)
    echo "Unknown OS ${os}"
    
esac