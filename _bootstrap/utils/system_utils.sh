
# system info {{{1
# neofetch {{{2
# [dylanaraps/neofetch: 🖼️ A command-line system information tool written in bash 3.2+](https://github.com/dylanaraps/neofetch)

if [ ! -x "$(command -v neofetch)" ]; then
    echo 'Installing neofetch'
	sudo apt install neofetch -y
fi

# htop {{{2
if [ ! -x "$(command -v htop)" ]; then
    echo 'Installing htop'
	sudo apt install htop -y
fi

# seearch {{{1
# fd - find alternative {{{2
# [sharkdp/fd: A simple, fast and user-friendly alternative to 'find'](https://github.com/sharkdp/fd)
# use to feed FZF

if [ ! -x "$(command -v fdfind)" ]; then
	echo 'Installing fd (fdfind)- find alternative'
	sudo apt install fd-find -y
fi

# binary is called fdfind
# add an `alias fd=fdfind` to your shells initialization file, in order to use fd
# in the same way as in this documentation.

# Ag {{{2
# [ggreer/the_silver_searcher: A code-searching tool similar to ack, but faster.](https://github.com/ggreer/the_silver_searcher)

if [ ! -x "$(command -v ag)" ]; then
    echo 'Installing Ag - silver searcher'
	sudo apt-get install silversearcher-ag -y
fi

# FZF {{{2
# [junegunn/fzf: A command-line fuzzy finder](https://github.com/junegunn/fzf)

# This is not necessary for fzf.vim plugin to function or to 'propogate' fzf
# .bashrc configs to fzf.vim. fzf.vim can work without this beeing installed.

# Reference for vim+fzf: [fzf/README-VIM.md at master · junegunn/fzf](https://github.com/junegunn/fzf/blob/master/README-VIM.md)

if [ ! -x "$(command -v fzf)" ]; then
    echo 'Installing FZF'
	sudo apt-get install fzf -y
fi


# Global variables {{{1
# for my custom or downloaded scripts, utilities
MY_BIN_DIR="${HOME}/bin"

# FS navigation {{{1

# z - jump around (smart cd) {{{2

PATH_TO_Z="${MY_BIN_DIR}/z.sh"

if [ ! -f "${PATH_TO_Z}" ]; then
	mkdir -p  "${MY_BIN_DIR}"
    echo "Installing z"
	# wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O "${PATH_TO_Z}"
	echo "Appending .bashrc under 'Z (smart cd)'"
	printf "\n\n# Z (smart cd) {{{1\n# (https://github.com/rupa/z)\n# initialize z\nsource "${PATH_TO_Z}" \n\n" >> $HOME/.bashrc

fi

