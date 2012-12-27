# Philip's Dot Files
These are the config files to set up a system to maximize my productivity.

## Installation
    git clone git@github.com:positron/dotfiles.git
    git submodule init
    git submodule update

run `./setup` in Unix/Cygwin shells and `setup.bat` in Windows.

## Vundle
Plugins are managed by the Vundle vim plugin. First time installation:

   git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
   vim +BundleInstall +qall

To update plugins:

   :BundleInstall!

To remove plugins after deleting them from the `.vimrc`:

   :BundleClean!

## Features
Lots of stuff I have accumulated over the years.

Most config files source a .local file if it exists so you can have configuration specific to one system.
