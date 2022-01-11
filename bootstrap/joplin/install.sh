#!/usr/bin/env bash


set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install joplin desktop app {{{1
# General Install script from [Joplin - an open source note taking and to-do application with synchronisation capabilities](https://joplinapp.org/help/#installation)
# installs appimage
echo 'Installing Joplin desktop'
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

# Following (bash) `command` test may not work for appimages.
if [ ! -x "$(command -v joplin-desktop)" ]; then
    echo 'Installing Joplin desktop'
    wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash
fi



# Install latest (v14.x) nodejs - Required for Terminal joplin
if [ ! -x "$(command -v node)" ]; then
    echo 'Installing Nodejs'
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get install -y nodejs
    #see also: https://github.com/nodesource/distributions/blob/master/README.md
fi

# Install joplin terminal app {{{1
if [ ! -x "$(command -v joplin)" ]; then
    echo 'Installing Joplin terminal'
    NPM_CONFIG_PREFIX=~/.joplin-bin npm install -g joplin
    sudo ln -s ~/.joplin-bin/bin/joplin /usr/bin/joplin
fi

