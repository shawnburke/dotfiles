[![Build Status](https://travis-ci.com/shawnburke/dotfiles.svg?branch=master)](https://travis-ci.com/shawnburke/dotfiles)

# Usage
This is my dotfiles but you're welcome to fork it!  The only thing you'll need to change is the .gitconfig that has my email and name in it, everything else should be generic.  But you might hate my tmux settings!

This will set up a good basic enviornment for Linux or OSX:

* wget, curl, netcat
* jq
* mosh
* vim, tmux
* direnv
* autojump

In addition, I've added a CI script to test any changes against a clean Ubuntu container.


## Basic system setup
For systems that have nothing, e.g. a Debian container run:

```
. dotfiles/tools/prereq.sh
```

This will install sudo, git, python.


## Standard system setup

Gets the right tools and packages in place:

```
. dotfiles/tools/init.sh
```

Idempotent so should be fine to run whenever.

## Do the things!

Once the above is set, run the install to set up the system.

** DO NOT SOURCE THIS **

```
dotfiles/install
```

And that should set up all the links.  To get everything working, it typically is best to exit the current session and log back in.  A cheat is to just run `zsh`.

Note Powerline will need the Powerline (PL) fonts for your terminal of choice.

See more:

* [General linux powerline fonts](https://github.com/powerline/fonts)
* [VSCode / Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/tutorials/powerline-setup).  Install the fonts then use `Cascadia Code PL` (or mono pl)

# Machine specific files

To specify extra values:

* `.gitconfig_local`
* `.bash_local`
* `.zsh_local`
* `.env_local`
* `.alias_local`
