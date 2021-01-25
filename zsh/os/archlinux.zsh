#!/bin/zsh

# Set Variables
export BROWSER=chromium
export EDITOR=nvim

# Set Path
export PATH="$HOME/.gem/ruby/2.6.0/bin:$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$PATH"
export PATH="$HOME/.yarn/bin:/var/lib/snapd/snap/bin:$PATH"
export GOPATH="$HOME/go"

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

# Update dircolors
eval $(dircolors ~/.dircolors)

# Setup less
export LESS="-RSM~gIsw"

# Ecrypt
alias mpriv='ecryptfs-mount-private; cd ~/Private'
alias upriv='cd ~; ecryptfs-umount-private'
