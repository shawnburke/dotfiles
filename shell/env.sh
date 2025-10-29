export PATH=$HOME/.local/bin:$PATH

# Lazy-load NVM (only load when node/npm/nvm commands are used)
export NVM_DIR="$HOME/.nvm"

# Create lazy-loading wrapper functions
_nvm_lazy_load() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

nvm() {
  _nvm_lazy_load
  nvm "$@"
}

node() {
  _nvm_lazy_load
  node "$@"
}

npm() {
  _nvm_lazy_load
  npm "$@"
}

npx() {
  _nvm_lazy_load
  npx "$@"
}

alias ll="ls -alFh"

if [ -f ~/.env_local ]
then
    source ~/.env_local
fi
