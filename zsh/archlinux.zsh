#!/bin/zsh

# Set Variables
export BROWSER=chromium
export EDITOR=vim

# Set Path
export PATH="$HOME/.gem/ruby/2.2.0/bin:$HOME/bin:$PATH"

# Use qt4-ssh-askpass for ssh ask dialog
export SSH_ASKPASS="/usr/bin/qt4-ssh-askpass"

# Arch PKG Management
alias pacsyu="sudo snp pacman -Syu"
alias pacsy="sudo pacman -Sy"
alias pacr="sudo pacman -Rs"
alias pac="sudo pacman -S"
alias pacs="pacman -Ss"
alias pacq="pacman -Q"
alias pacu="sudo pacman -U"

alias paca="pacaur -S"
alias pacas="pacaur -Ss"
#alias pacau="pacaur -Su"

#alias yaos="yaourt -Ss"
#alias yao="yaourt -S"
#alias yaosyu="yaourt -Su"
#alias yaor="yaourt -R"

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
