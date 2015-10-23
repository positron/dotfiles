#!/bin/bash

# This provisioning script is run as the vagrant user

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install python3 vim-nox gem tmux ruby-dev dos2unix
sudo gem install jekyll s3_website

cd ~
mkdir -p projects
cd projects

if [ ! -d "dotfiles" ]; then
  git clone https://github.com/positron/dotfiles.git
  pushd dotfiles
   
  # This vagrantfile is exclusively for personal projects
  git config --global user.email philipjagielski@gmail.com
  ./setup

  popd
fi

if [ ! -d "philipjagielski.com" ]; then
  git clone https://github.com/positron/philipjagielski.com.git
fi
