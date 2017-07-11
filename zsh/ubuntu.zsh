#!/bin/zsh

# Set Variables
export BROWSER=chromium-browser
export EDITOR=nvim

# Set Path
export PATH="$HOME/.gem/ruby/2.3.0/bin:$HOME/bin:$PATH"

# Linux LS aliases
alias ls="ls --color=auto -CFh"
alias sl="ls"
alias ll="ls -l"
alias lx="ls -X"
alias lv="ls -v"

# Ubuntu PKG Management
alias apti="sudo apt install"
alias aptc="sudo apt autoclean"
alias aptd="sudo apt update && sudo apt dist-upgrade"
alias aptg="sudo apt update && sudo apt upgrade"
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
