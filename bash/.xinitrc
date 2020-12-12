
# Keyboard Custom Mappings / layout customization {{{1

# TODO:
# FIXME: ATTENTION: SOURCE this MANUALLY after login Since:
# when in .profile following does not become effective, I need to source
# .profile again after login. 
# 

# ~/.profile runs early in the login sequence. If your desktop environment configures a keyboard layout, it can overwrite the settings you've just loaded.
# Put your settings in a file called ~/.Xmodmap

# **NB**: In case this is Virtual Machine and host Windows OS has already remapped 
# keys on a registry level (e.g. via SharpKeys, and not via PowerToys, AutoHotKeys, etc)
# then such remapping affects this machine and no similar mapping is needed here.
# Enable following if not in a VM or host OS has no customized keyboard.
# xmodmap ~/.Xmodmap

# Caps lock is mapped to Control_L (via xmodmap) and 
# hitting it triggers Escape (after quick release)
xcape -e 'Control_L=Escape' -t 300


# References
#
# [key bindings - Other ways to exit Insert mode besides Escape - Vi and Vim Stack Exchange](https://vi.stackexchange.com/questions/300/other-ways-to-exit-insert-mode-besides-escape/349?newreg=dd5c5b7d089a40008c12e491b9e03fe0)
# [vim - How to remap Caps Lock to Control, then disable the Left Control on Linux? - Stack Overflow](https://stackoverflow.com/questions/30107038/how-to-remap-caps-lock-to-control-then-disable-the-left-control-on-linux)
# [keyboard - How to swap ctrl and caps lock using xmodmap - Super User](https://superuser.com/questions/268269/how-to-swap-ctrl-and-caps-lock-using-xmodmap)
#
