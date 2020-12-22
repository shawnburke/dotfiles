

# Ensure agent is running
ssh-add -l &>/dev/null
if [ "$?" = 2 ]; then
    # Could not open a connection to your authentication agent.

    # Load stored agent connection info.
    test -r ~/.ssh-agent && \
        eval "$(<~/.ssh-agent)" >/dev/null

    ssh-add -l &>/dev/null
    if [ "$?" = 2 ]; then
        # Start agent and store agent connection info.
        (umask 066; ssh-agent > ~/.ssh-agent)
        eval "$(<~/.ssh-agent)" >/dev/null
    fi
fi

# Load identities
ssh-add -l &>/dev/null
if [ "$?" = 1 ]; then

  if [ -d ~/.ssh ]
  then 
     # Get all keys that start with id_ in .ssh dir, add to ssh-add. ssh-add outputs to stderr, so we want to suppress
     # that or zsh/powershell will get mad.  Standard output is like "Identity added..."
     find ~/.ssh -maxdepth 1 -name "id_*" -type f ! -name "*.*" | xargs -I S ssh-add -A S 2>/dev/null 
  fi
fi
