# curl
# wget
# jq
# zsh / oh my zsh
# highlight


function install_linux_binary {

    package=$2

    package=${package:-$1}

    if ! which $1 >/dev/null 
    then
        echo "Installing $1..."
        sudo apt-get install -yq $package
    else
        echo "$1 already installed"
    fi

}

function install_linux {
    install_linux_binary curl
    install_linux_binary wget
    install_linux_binary highlight
    install_linuq_binary jq
    install_linux_binary zsh
    install_linux_binary vim
    install_linux_binary tmux
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}


function install_osx {
    # brew
    # tools above
    echo "not yet impl"
}


os=$(uname -s)


case $os in
Linux)
    install_linux
    ;;
Darwin)
    install_darwin
    ;;
*)
    echo "Unknown OS ${os}"
    
esac
