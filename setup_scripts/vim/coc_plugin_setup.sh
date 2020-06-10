#!/usr/bin/env bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install latest nodejs
if [ ! -x "$(command -v node)" ]; then
    echo 'Installing Nodejs'
    #curl --fail -LSs https://install-node.now.sh/latest | sh
	#error: sh: 30: set: Illegal option -o pipefail
	#also like: curl -sL install-node.now.sh | sh
    #export PATH="/usr/local/bin/:$PATH"
    # Or use apt-get
    #sudo apt-get install nodejs
    #or: (comes with npm):
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get install -y nodejs
    #see also: https://github.com/nodesource/distributions/blob/master/README.md
fi

if [ ! -x "$(command -v yarn)" ]; then
    echo 'Installing yarn'
    curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
    echo 'source ~/.bashrc before  lunching vim'
    #or my try
    #https://classic.yarnpkg.com/en/docs/install#debian-stable 
    #sudo apt remove cmdtest
    #sudo apt update && sudo apt install yarn

fi


if [ ! -x "$(command -v clangd)" ]; then
    echo 'Installing clangd for C/C++/Objective-C support'
    echo 'source ~/.bashrc before  lunching vim'
    sudo apt-get install clangd-9
    #will install clangd as /usr/bin/clangd-9. Make it the default clangd:
    echo 'making clangd-9 as default clangd'
    sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100
    echo 'Also instal bear - for clangd to understand your source code'
fi

#Clangd tooling
    #To understand your source code, clangd needs to know your build flags. 
    #compile_commands.json file is needed to provide compile commands for 
    #every source file in a project. 
    #Clangd will look in the parent directories of the files you edit 
    #looking for it.

if [ ! -x "$(command -v bear)" ]; then
    echo 'Installing bear for clangd'
    echo 'source ~/.bashrc before  lunching vim'
    sudo apt install bear
    echo '-----'
    echo 'bear usage:'
    echo '$make clean; bear make'
    echo 'Output file compile_commands.json is saved in the current directory'
    echo '-----'
fi

## Use package feature to install coc.nvim
#
## for vim8
#mkdir -p ~/.vim/pack/coc/start
#cd ~/.vim/pack/coc/start
#curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
## for neovim
## mkdir -p ~/.local/share/nvim/site/pack/coc/start
## cd ~/.local/share/nvim/site/pack/coc/start
## curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -
#
## Install extensions
#mkdir -p ~/.config/coc/extensions
#cd ~/.config/coc/extensions
#if [ ! -f package.json ]
#then
#  echo '{"dependencies":{}}'> package.json
#fi
## Change extension names to the extensions you need
#npm install coc-snippets --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
