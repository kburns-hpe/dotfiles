#!/bin/zsh

# Set Variables
export BROWSER=chromium-browser
export EDITOR=nvim

# Set Path
export PATH="$HOME/.local/bin:$HOME/.gem/ruby/2.5.0/bin:$HOME/bin:$PATH:$HOME/go/bin"
export PATH="$PATH:/snap/bin:$HOME/.yarn/bin"
export GOPATH="$HOME/go"

# Linux LS aliases
alias ls="colorls"
alias sl="ls"
alias ll="ls -l"
alias lx="ls -X"
alias lv="ls -v"

# Ubuntu PKG Management
alias aptc="sudo apt autoclean"
alias aptd="sudo apt update && sudo apt dist-upgrade"
alias aptg="sudo apt update && sudo apt upgrade"
alias apti="sudo apt install"
alias aptr="sudo apt remove"
alias apts="apt search"
alias aptu="sudo apt update"

# Highlight a specific search and pipe it through less
alias hla='ack-grep -i --passthru --color --pager="less -R"'

# Only show the matching lines, highlighted with a color
alias hl='ack-grep -i --color --pager="less -R"'

# Find a specific keyword in all files in current directory and highlight it

function shl() {
    searchfor="$1"
    if [ "$2" ]; then
        highlight="$2"
    else
        highlight="$1"
    fi

    find . -type f -exec egrep -i "$searchfor" {} /dev/null \; | ack-grep -i --passthru --color --pager="less -R" "$highlight"
}

# Use qt4-ssh-askpass for ssh ask dialog
export SSH_ASKPASS="/usr/bin/qt4-ssh-askpass"

# BTRFS DF alias
alias bdf="btrfs filesystem df"

# Useful when copying files on a COW-enabled file system
alias cp="cp -i --reflink=auto"

# Other aliases
alias open="xdg-open"
alias xqf="xdg-mime query filetype"
alias xqd="xdg-mime query default"
alias xd="xdg-mime default"
alias scpnh='scp -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null"'
alias irc='TERM=tmux-256color weechat-curses'

eval $(dircolors ~/.dircolors)
