# Usage

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