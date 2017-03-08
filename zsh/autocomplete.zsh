#!/bin/zsh

# Setup directory for custom auto completion files
fpath=(~/.zsh/completion $fpath)

# Enable smart autocompletion
autoload -U compinit && compinit
setopt complete_in_word

# Enable menu selection when hitting tab twice
zstyle ':completion:*' menu select

# Set pid completion for kill
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -e -o pid,user,tty,cmd'

#Set Warning message when nothing can be autocompleted
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Enable the use of auto completion cache to speed up some functions, such as pacman
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Allow 1 mistake in auto completion (fuzzy)
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Don't auto complete parent directory when using cd ../
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Disable user auto completion for ssh
zstyle ':completion:*:*:ssh*' users
zstyle ':completion:*:*:scp*' users

# Only complete hosts that are in the ~/.ssh/config file
zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# puppet development environment (pde) script autocompletion
compdef "_files -W $HOME/git/puppet/modules" pde
