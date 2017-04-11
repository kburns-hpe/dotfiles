#!/bin/zsh

# Set Variables
export BROWSER=chromium
export EDITOR=nvim

# Set Path
export PATH="$HOME/.gem/ruby/2.4.0/bin:$HOME/bin:$PATH"

# Use qt4-ssh-askpass for ssh ask dialog
export SSH_ASKPASS="/usr/bin/qt4-ssh-askpass"

# Arch PKG Management
alias pac="sudo pacman -S"
alias paca="pacaur -S"
alias pacas="pacaur -Ss"
alias pacau="pacaur -Su"
alias pacq="pacman -Q"
alias pacr="sudo pacman -Rs"
alias pacs="pacman -Ss"
alias pacsy="sudo pacman -Sy"
alias pacsyu="sudo pacman -Syu"
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
alias xqf="xdg-mime query filetype"
alias xqd="xdg-mime query default"
alias xd="xdg-mime default"
alias k="kitchen"
alias scpnh='scp -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null"'

# Update dircolors
eval $(dircolors ~/.dircolors)

# Add colors to less
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
