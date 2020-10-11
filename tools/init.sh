
function install_linux_binary {

    package=$2

    package=${package:-$1}

    if ! which $1 >/dev/null 
    then
        echo "Installing $1..."
        sudo apt-get install -yq $package >/dev/null
    else
        echo "$1 already installed"
    fi

}

function install_linux {

    echo "Installing fonts-powerline..."
    sudo apt-get install -yq fonts-powerline >/dev/null
    install_linux_binary curl
    install_linux_binary wget
    install_linux_binary highlight
    install_linux_binary jq
    install_linux_binary zsh
    install_linux_binary vim
    install_linux_binary tmux
    install_linux_binary nc netcat
    install_linux_binary direnv
    install_linux_binary autojump

    # install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

}


function install_osx {
    # brew
    # tools above
    if ! which brew </dev/null
    then 
        echo "Please install brew, then run again."
        exit 1
    fi

    brew install curl
    brew install wget
    brew install highlight
    brew install jq
    brew install autojump
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
    echo "Unknown OS (${os})"
    
esac


echo "Init complete, now exit shell and run source ~/dotfiles/install"