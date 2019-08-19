# Philip's Dot Files
These are the config files to set up a system to maximize my productivity.

## Installation
Run ./config-macos.sh to configure OS X.

Run `./setup` in OS X/*nix/Cygwin shells and `setup.bat` in Windows to install all the dotfiles relevant to that platform.

## Updating vim plugins
Plugins are managed by the [Vundle plugin][vundle].

To install and update all plugins:

    :PluginInstall!

To delete plugins after deleting them from `.vimrc`:

    :PluginClean!

[vundle]: https://github.com/gmarik/vundle

## Windows specific
Download vim [from here][winvim]. This build is 64bit with a lot of goodies compiled in.

[winvim]: http://solar-blogg.blogspot.ca/p/vim-build.html

## Features
Lots of stuff I have accumulated over the years. :-)

Most config files source a .local version of that file if it exists so you can have configuration specific to one system.
