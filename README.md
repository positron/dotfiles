# Philip's Dot Files
These are the config files to set up a system to maximize my productivity.

## Installation
Run ./config-macos.sh to configure OS X.

Run `./setup` in OS X/*nix/WSL shells to install utilities and link all dotfiles.

## Updating vim plugins
Plugins are managed by the [vim-plug plugin][vim-plug].

To install and update all plugins:

    :PlugInstall

To delete plugins after deleting them from `.vimrc`:

    :PlugClean!
    
To upgrade plugins, run:

    :PlugSnapshot "generate script for restoring the current snapshot of the plugins
    :PlugUpdate
    :PlugUpgrade  "upgrades vim-plug itself

[vim-plug]: https://github.com/junegunn/vim-plug

## Features
Lots of stuff I have accumulated over the years. :-)

Most config files source a .local version of that file if it exists (e.g. for secrets or work specific aliases).

## WSL
The best setup I've found is to install ConEmu and use that.

- [Follow setup instructions to get a WSL shell](https://conemu.github.io/en/BashOnWindows.html)
