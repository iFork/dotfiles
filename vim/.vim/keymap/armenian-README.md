# Vim Armenian Keymaps



## Description of files starting with `armenian-*`
From `alt` branch of [blinskey/vim-armenian-keymaps: ՀայԵրէն keymaps for Vim](https://github.com/blinskey/vim-armenian-keymaps#activating-a-keymap)
A set of alternate Vim keymaps for the Armenian alphabet, based on the xkeyboard-config Armenian keymaps,
that are not included in the Vim source code.
( The `master` branch provides a pair of common mappings for the Western and Eastern dialects that cover the full alphabet and all standard punctuation marks. These are included in the Vim source code. )

## Usage

You can switch between Armenian and Latin characters in Insert mode using Ctrl-^. To disable the keymap at Vim startup so that Insert mode uses Latin characters by default, add the following lines to your `.vimrc`:

set iminsert=0
set imsearch=0

For more information on keymaps, see `:help mbyte-keymap`.

## Issue

Armenian characters overlap if no supporting monospace font is set.
DejaVu Sans Mono has Armenian monospace gliphs. When this font is used no chracters overlap.

