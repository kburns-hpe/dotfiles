#!/bin/zsh

umask 022
setopt autolist automenu nobeep

# useful for path editing — backward-delete-word, but with / as additional delimiter
backward-delete-to-slash () {
  local WORDCHARS=${WORDCHARS//\//}
  zle .backward-delete-word
}
zle -N backward-delete-to-slash

# Enable extended globs (i.e. **/)
setopt extended_glob

# Enable auto correct for commands
setopt correct
set -o noclobber

# Source dircolors
eval "$(dircolors ~/.dircolors)"
