#!/usr/bin/env bash

# Installing jsctags for better JavaScript tag support 
# e.g. for vim tagbar
# DEPENDENCY: This requires 'tern', this dependency is now handled by 'tern_for_vim'

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


if [ ! -x "$(command -v jsctags)" ]; then
	echo 'Installing jsctags for better JS tags support (e.g. in vim tagbar)'
	echo 'This requires `tern`, this dependency is now handled by `tern_for_vim`'
    echo 'source ~/.bashrc before  lunching vim'
    sudo npm install -g git+https://github.com/ramitos/jsctags.git
fi

# Usage
#
# $ jsctags [--dir=/path/to] /path/to/file.js [-f]
#
# $ cat /path/to/file.js | jsctags [--dir=/path/to] [--file=/path/to/file.js] [-f]
#
# By default, jsctags will output a JSON file. Use the -f flag to output an exuberant ctags-compatible file.

# Usage with Vim
#
# If you'd like to take a JavaScript project and generate a tags file that Vim can parse, you can use the below command. It searches your directory for any .js files, excluding ./node_modules, formats the tags correctly for Vim and outputs them into tags.
#
# `
# find . -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; | sed '/^$/d' | LANG=C sort > tags
# `

# LOG - Install on Jul 11, 2020
# npm WARN deprecated lodash.isarray@4.0.0: This package is deprecated. Use Array.isArray.
# npm WARN deprecated node-uuid@1.4.8: Use uuid module instead
# /usr/bin/jsctags -> /usr/lib/node_modules/jsctags/bin/jsctags
# /usr/bin/xjsctags -> /usr/lib/node_modules/jsctags/bin/xjsctags
# + jsctags@5.2.2
# added 60 packages from 194 contributors in 10.948s

