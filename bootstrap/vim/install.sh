#!/usr/bin/env bash

# Vim installation

# Log of (used) vim versions:
	# Huge version with X11-Athena GUI.

# add ppa repo for ubuntu
# https://launchpad.net/~jonathonf/+archive/ubuntu/vim/+packages

sudo add-apt-repository ppa:jonathonf/vim
sudo apt-get update

# use `apt install vim<tab complition>` to see available versions after apt update
# Installing a verion w GUI will also install a 'huge' version of terminal vim 

# e.g.
sudo apt-get install vim-athena

