#!/usr/bin/env bash

# xcape 


# Install {{{1

if [ ! -x "$(command -v xcape)" ]; then
	echo 'Installing xcape'
	DISTRO=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')
	echo "on Linux distro: $DISTRO"
	# in Ubuntu
	if [[ "$DISTRO" == "ubuntu"* ]]; then
		sudo apt install xcape -y
	elif [[ "$DISTRO" == "manjaro"* ]]; then
		sudo pacman -S xcape
	else
		echo "distro's install command is unknown"
	fi
fi


# xcape Usage {{{1

# $ xcape [-d] [-f] [-t <timeout ms>] [-e <map-expression>]

# -d Debug mode. Does not fork into the background. Prints debug information.
# -f Foreground mode. Does not fork into the background.
# -t <timeout ms> If you hold a key longer than this timeout, xcape will not generate a key event. Default is 500 ms.
# -e <map-expression>
# The expression has the grammar 'ModKey=Key[|OtherKey][;NextExpression]'
# The list of key names is found in the header file X11/keysymdef.h (remove the XK_ prefix)

# Example in .profile/bashrc
# hitting Control_L (Caps lock) will trigger Escape (after quick release)
# xcape -e 'Control_L=Escape' -t 300

