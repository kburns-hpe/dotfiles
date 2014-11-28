dotfiles
========

various dotfiles, mostly for Linux.  

## awesome 
* run setup_awesome.sh to create ~/.config/awesome
* edit ~/.config/awesome/config.lua to customize setup
* Key bindings are in ~/.config/awesome/bindings.lua
* Window rules are in ~/.config/awesome/rules.lua
* Currently the only way to remove widgets is to comment them out in widgets.lua

## vim
* run setup_vim.sh to create ~/.vimrc and ~/.vim directory and setup symlinks

## xconfigs
* Cobalt Theme for urxvt
* Copy xresources to ~/.Xresources
* xmodmap remaps right ctl to be a hyper key and right alt to be a super

## zsh
* zshrc should be copied/linked to ~/.zshrc
* the rest of the files should be copied/linked under the ~/.zsh/ directory
* any file ending in .zsh in ~/.zsh/ will be sourced
