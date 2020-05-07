#!/bin/zsh

# Various aliases
alias free="free -m"
alias grep="grep --color -i"
alias grepc="grep --color=always -i"
alias sz="source ~/.zshrc"
alias rgi="rg -i"

# Command Alternatives
alias cat='batcat'
alias cap='batcat -p'
alias ping='prettyping --nolegend'
alias ndu="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

# VIM aliases
alias vi=nvim
alias svi="sudo -e"

# extra dots
alias -g ...="../.."
alias -g ....="../../.."
alias -g .....="../../../.."

# Exercism aliases
alias ef="exercism f"
alias es="exercism s"
