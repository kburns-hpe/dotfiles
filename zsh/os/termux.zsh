#!/bin/zsh

# Set Variables
export BROWSER=termux-open-url
export EDITOR=nvim

# Set Path
export PATH="$HOME/.local/bin:$HOME/.gem/ruby/2.3.0/bin:$HOME/bin:$PATH:$HOME/go/bin"

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

# Other aliases
alias open="xdg-open"
alias xqf="xdg-mime query filetype"
alias xqd="xdg-mime query default"
alias xd="xdg-mime default"

