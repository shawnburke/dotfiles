
function install_apt_package {
    if ! dpkg -l $1 2&>1 >/dev/null
    then
        echo "Installing $1..."
        sudo apt-get install -yq $package >/dev/null
    else
        echo "$1 already installed"
    fi

}

function install_linux {
    sudo apt-get install -yq \
        curl wget netcat \
        highlight \
        jq \
        zsh \
        direnv autojump \
        vim tmux
    # install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

}

function install_brew {
    if ! brew list $1 2&>1 > /dev/null
    then
        echo "Installing $1"
        brew install $1
    else
        echo "$1 already installed"
    fi
}


function install_osx {
    # brew
    # tools above
    if ! which brew >/dev/null
    then 
        echo "Please install brew, then run again."
        return
    fi

    install_brew wget
    install_brew highlight
    install_brew jq
    install_brew autojump
    install_brew direnv
    install_brew tmux
    install_brew autojump
}

 
os=$(uname -s)

case $os in
Linux)
    install_linux
    ;;
Darwin)
    install_osx
    ;;
*)
    echo "Unknown OS (${os})"
    
esac


echo "Init complete, now exit shell and run source ~/dotfiles/install"