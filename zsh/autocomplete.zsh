#!/bin/zsh

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
