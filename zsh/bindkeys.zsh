#!/bin/zsh

# Setup substring search
## Set Bind Keys if tmux/screen is running
if [ "$TERM" = "screen-256color" -o "$TERM" = "screen" ]; then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
else
  zmodload zsh/terminfo
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
fi

#bind keys
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "\e[Z" reverse-menu-complete # Shift+n
