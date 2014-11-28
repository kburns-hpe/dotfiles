#!/bin/zsh

# Set Variables
export BROWSER=chrome
export EDITOR=vim

# Set Path
export PATH="$HOME/bin:$PATH"

# Shortcuts to update cygwin
alias cygports="cygstart -- /cygdrive/c/cygwin/setup-x86.exe -K http://cygwinports.org/ports.gpg -s ftp://ftp.cygwinports.org/pub/cygwinports"
alias cygsetup="cygstart -- /cygdrive/c/cygwin/setup-x86.exe -s http://mirrors.xmission.com"

# Use keychain for global ssh-agent.  This will ask for passphrase on first use.
alias ssh='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/id_rsa) && ssh'
alias scp='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/id_rsa) && scp'

# Highlight a specific search and pipe it through less
alias hl='ack --passthru --color --pager="less -R"'
