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
alias apt="sudo apt-get install"
alias aptc="sudo apt-get autoclean"
alias aptd="sudo apt-get update && sudo apt-get dist-upgrade"
alias apti="apt-cache show"
alias aptg="sudo apt-get update && sudo apt-get upgrade"
alias apts="apt-cache search"
alias aptu="sudo apt-get update"

# Use keychain for global ssh-agent.  This will ask for passphrase on first use.
export SSH_ASKPASS="/usr/bin/ssh-askpass"
alias ssh='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/id_rsa) && ssh'
alias scp='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/id_rsa) && scp'

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
