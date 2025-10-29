
# Ensure agent is running (optimized to reduce ssh-add calls)
if ! ssh-add -l &>/dev/null; then
    # Exit code 1 = agent running but no identities, 2 = no agent connection
    if [ "$?" = 2 ]; then
        # Could not open a connection to your authentication agent.

        # Load stored agent connection info.
        if [ -r ~/.ssh-agent ]; then
            eval "$(<~/.ssh-agent)" >/dev/null

            # Check if loaded agent is actually running
            if ! ssh-add -l &>/dev/null && [ "$?" = 2 ]; then
                # Start agent and store agent connection info.
                (umask 066; ssh-agent > ~/.ssh-agent)
                eval "$(<~/.ssh-agent)" >/dev/null
            fi
        else
            # No stored agent, start a new one
            (umask 066; ssh-agent > ~/.ssh-agent)
            eval "$(<~/.ssh-agent)" >/dev/null
        fi
    fi
fi
