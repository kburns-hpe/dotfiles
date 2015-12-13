#!/bin/zsh

# Set Variables
export BROWSER=chromium
export EDITOR=nvim

# Set Path
export PATH="$HOME/.gem/ruby/2.2.0/bin:$HOME/bin:$PATH"
export PATH="/home/kburns/.chefdk/gem/ruby/2.1.0/bin:$PATH"

# Use qt4-ssh-askpass for ssh ask dialog
export SSH_ASKPASS="/usr/bin/qt4-ssh-askpass"

# Arch PKG Management
alias pac="sudo pacman -S"
alias paca="pacaur -S"
alias pacas="pacaur -Ss"
alias pacq="pacman -Q"
alias pacr="sudo pacman -Rs"
alias pacs="pacman -Ss"
alias pacsy="sudo pacman -Sy"
alias pacsyu="sudo snp pacman -Syu"
alias pacu="sudo pacman -U"

# Highlight a specific search and pipe it through less
alias hl='ack --color --pager="most"'
alias hla='ack --passthru --color --pager="most"'

# Linux LS aliases
alias ls="ls --color=auto -CFh"
alias sl="ls"
alias ll="ls -l"
alias lx="ls -X"
alias lv="ls -v"

# Force tmux to always use 256 colors
alias tmux="tmux -2"

# BTRFS DF alias
alias bdf="btrfs filesystem df"

# Useful when copying files on a COW-enabled file system
alias cp="cp -i --reflink=auto"

# Use nvim instead of vim
alias vim="nvim"
alias vi="nvim"

# Other aliases
alias open="xdg-open"

# Enable true color support for neovim
export NVIM_TUI_ENABLE_TRUE_COLOR=1
