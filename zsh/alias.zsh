#!/bin/zsh

# Various aliases
alias free="free -m"
alias grep="grep --color -i"
alias grepc="grep --color=always -i"
alias sz="source ~/.zshrc"
alias rgi="rg -i"

# ls aliases
alias ls="exa --color=always --group-directories-first"
alias ll="ls -l"
alias la="ls -a"
alias lal="ls -la"
alias ld="ls -D"
alias ldl="ls -Dl"
# Command Alternatives
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

# bat aliases
if which batcat >/dev/null; then
  alias cat='batcat -pp --theme=cobalt2'
  alias catl='batcat --pager=never --theme=cobalt2'
  alias catp='batcat --theme=cobalt2'
else
  alias cat='bat -pp --theme=cobalt2'
  alias catl='bat --pager=never --theme=cobalt2'
  alias catp='bat --theme=cobalt2'
fi
