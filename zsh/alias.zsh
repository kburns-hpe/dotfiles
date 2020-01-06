#!/bin/zsh

# Various aliases
alias free="free -m"
alias grep="grep --color -i"
alias grepc="grep --color=always -i"
alias sz="source ~/.zshrc"

# Command Alternatives
alias cat='bat'
alias ping='prettyping --nolegend'
alias ndu="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

# VIM aliases
alias vi=nvim
alias svi="sudoedit"

# extra dots
alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."

# Exercism aliases
alias ef="exercism f"
alias es="exercism s"
