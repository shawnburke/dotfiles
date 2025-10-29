
function install_apt_package {
    if ! dpkg -l $1 2>&1 >/dev/null
    then
        echo "Installing $1..."
        sudo apt-get install -yq $1 >/dev/null
    else
        echo "$1 already installed"
    fi

}


function install_common  {

	# NVM
	echo Installing NVM...
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

}
function install_linux {
    if ! sudo apt-get update
    then
	 echo "Package install failed, please run apt update then prereqs_linux.sh"
    fi
    export DEBIAN_FRONTEND=noninteractive 
    install_apt_package apt-utils
    install_apt_package curl
    install_apt_package wget
    install_apt_package netcat-openbsd
    install_apt_package net-tools
    install_apt_package highlight
    install_apt_package tree
    install_apt_package silversearcher-ag
    install_apt_package jq
    install_apt_package mosh
    install_apt_package zsh
    install_apt_package direnv
    install_apt_package autojump
    install_apt_package tig
    install_apt_package vim
    install_apt_package neovim
    install_apt_package tmux
    install_apt_package openjdk-17-jdk
    install_apt_package fonts-powerline

# finish java install
    if ! grep JAVA_HOME /etc/environment
    then
    	jhome=$(ls -al /etc/alternatives/java | awk '{print $11}')
    	echo "export JAVA_HOME=${jhome/\/bin\/java/}" | sudo tee -a /etc/environment
    fi

    install_common
}



function install_brew {

    if ! brew list $1 2>&1 > /dev/null
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


    # find brew
    if ! which brew >/dev/null
    then
	# first see if brew is installed, then if not, install it
	if [ ! -x /opt/homebrew/bin/brew ]
	then 
	  echo "Homebrew not found, installing"
	  export NONINTERACTIVE=1
	  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	# check again, make sure it worked
	if [ ! -x  /opt/homebrew/bin/brew ]
	then
		echo "Brew  not installed, please install from https://brew.sh/ then rerun"
		return
	fi
	
	# Ok, add it to env local and the path for the remainder of the script
	echo "Found brew but is not on path, adding to .env_local"
	if ! grep -q "/opt/homebrew/bin" ~/.env_local
	then
		echo 'export PATH=$PATH:/opt/homebrew/bin' >> ~/.env_local
	fi
	export PATH=$PATH:/opt/homebrew/bin
    fi



    install_brew wget
    install_brew highlight
    install_brew jq
    install_brew autojump
    install_brew direnv
    install_brew tmux
    install_brew autojump
    install_brew mosh
    install_brew tree
    install_brew tig
    install_brew neovim
    install_brew the_silver_searcher
    install_brew maccy
    install_common
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


 # install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

# Install Vim/Neovim plugin helper
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


echo "Init complete, now exit shell and run ~/dotfiles/install"
