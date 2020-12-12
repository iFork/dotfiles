# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# monitor resolution {{{1
# for Gnome Xorg

DESKTOP_ENV="$(loginctl show-session $(loginctl | grep $(whoami) | awk '{print $1}') -p Type --value)"
if [ "$DESKTOP_ENV" = "x11" ]; then
	# add new mode spec as printed by `cvt 2561 1440` 
	# (copy modeline from its output, may drop _60.00 part)
	# (change resolution numbers as needed)

	# 16:9
	xrandr --newmode "2560x1440"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync
	#add the new created mode for your display device,
	#get display device name from `xrandr` command.
	xrandr --addmode Virtual1 2560x1440  
	##Finally Apply the new resolution in the Display settings or by:
	#xrandr --output Virtual1 --mode 2560x1440 # causes ERROR "Can't open Display"

	# 5:~4 / for square 4x4 VMware window
	# `cvt 1646 1367` - area measured by snagit capture tool
	xrandr --newmode "1648x1367"  190.25  1648 1768 1944 2240  1367 1370 1380 1417 -hsync +vsync
	xrandr --addmode Virtual1 1648x1367
fi



# Read Manuals in vim {{{1

# per vim-utils/vim-man plugin suggestion:
export MANPAGER="vim -c \"Man $1 $2\" -c 'silent only'"

# export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu nornu noma' -\""
# credit: https://zameermanji.com/blog/2012/12/30/using-vim-as-manpager/
# col utility to remove extra ^H (backspace) characters because they are not handled correctly by vim
# ft=man enables the coloring of the man page.
# ts=8 ensures the width of tab characters matches less.
# nomod removes the modification warning when trying to quit.
# nonu removes line numbers.
# nolist disables listchars so trailing whitespace and extra tabs are not highlighted.
# noma sets the buffer to not be modifiable.

# or per vim's :h man: `export MANPAGER="vim -M +MANPAGER -" `

