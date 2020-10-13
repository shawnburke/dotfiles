alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ccat='highlight -O ansi --force'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'


if [ -f ~/.alias_local ]
then
    source ~/.alias_local
fi

