#Install pre-patched fonts required by 
#statusline plugins - airline, powerline, etc.


#sudo apt-get install fonts-powerline
	#problematic - installed fonts do not show up in terminal's font picker
	#in fact: fonts-powerline package contains only the "Powerline Symbols" 
	#font, which is a small font containing only the special Powerline 
	#symbol characters, and no normal characters 


#OR
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts


#Alternative steps

#clone this repo
#run ./install.sh from the repo
#add the files 10
# https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
# & 50
# https://github.com/powerline/fonts/blob/master/fontconfig/50-enable-terminess-powerline.conf# to fontconfig/conf.d/ directory
#Note: fc-cache -vf in Ubuntu Disco checks in ~/.fontconfig/conf.d, 
# it could be ~/.config/fontconfig/conf.d/ otherwise

#Terminal font config

#Now open your terminal emulation application and go to preferences->profile and change the font to the patched font. 
#For example: Mine was FiraMono Regular, changed to FiraMono for powerline.
#or droid sans mono dotted for powerline regular
#Save and the exit preferences, you should see the new font now

#KNOWN ISSUES

#Fontconfig - Terminess Powerline 

#In some distributions, Terminess Powerline is ignored by default and must be 
#explicitly allowed. A fontconfig file is provided which enables it. 
#Copy this file 
# https://github.com/powerline/fonts/blob/master/fontconfig/50-enable-terminess-powerline.conf
#from the fontconfig directory to your home folder under 
#~/.config/fontconfig/conf.d (create it if it doesn't exist) 
#and re-run fc-cache -vf.


#Terminal specific issues

#iTerm2 users need to set both the Regular font and the Non-ASCII Font in 
#"iTerm > Preferences > Profiles > Text" to use a patched font

#links
#prtepatched fonts
# https://github.com/powerline/fonts

#docs on patching fonts
# https://powerline.readthedocs.io/en/master/installation.html#patched-fonts

