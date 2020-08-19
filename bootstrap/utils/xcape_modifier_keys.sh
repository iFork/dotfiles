# xcape 
# [alols/xcape: Linux utility to configure modifier keys to act as other keys when pressed and released on their own.](https://github.com/alols/xcape)

# Install {{{1

if [ ! -x "$(command -v xcape)" ]; then
    echo 'Installing xcape'
	sudo apt install xcape -y
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

