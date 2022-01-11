#!/usr/bin/env bash

# Installing Heroku

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


if [ ! -x "$(command -v npm)" ]; then
	echo 'WARNING: npm is missing. You need to install npm!'
fi

if [ ! -x "$(command -v git)" ]; then
	echo 'WARNING: git is missing. You need to install git!'
fi

if [ ! -x "$(command -v heroku)" ]; then
	echo 'Installing Heroku...'
	sudo snap install heroku --classic
else
	echo 'Heroku is already present...'
fi


