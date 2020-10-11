eval "$(direnv hook bash)"

function tools_linux {
    [[ -f /usr/share/autojump/autojump.sh ]] &&  . /usr/share/autojump/autojump.sh || echo "Autojump not installed"
}

function tools_osx {
     [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
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