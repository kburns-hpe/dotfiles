#!/bin/zsh

bindkey -v
# Setup substring search
## Set Bind Keys if tmux/screen is running
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

#bind keys
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey '^b' backward-word
bindkey '^f' forward-word
bindkey "\e[Z" reverse-menu-complete # Shift+n
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^A' vi-beginning-of-line
bindkey '^E' vi-end-of-line
