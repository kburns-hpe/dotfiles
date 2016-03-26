#!/bin/zsh

# Various aliases
alias free="free -m"
alias grep="grep --color -i"
alias grepc="grep --color=always -i"
alias sz="source ~/.zshrc"

# VIM aliases
alias vi=vim
alias viol='vim -c "source ~/.vim/outline.vimrc" $*'
alias svi="sudoedit" 

# idea aliases
alias ic='idea create'
alias is='idea solve'
alias il='idea list'

# load rarely used zsh functions
alias loadzftp="autoload -U zfinit && zfinit"
alias loadtcpopen="autoload -U tcp_open && tcp_open"

# extra dots
alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."

# ttytter alias for options
alias ttytter="ttytter -ansi -verify"

# Add output to sprunge
alias pbin="curl -F 'sprunge=<-' http://sprunge.us | xsel -i -p;xsel -p"

# mplayer - fix pitch when speeding up videos
alias mp="mplayer -af scaletempo"
