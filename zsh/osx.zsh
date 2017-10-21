#!/bin/zsh

# Set Variables
export BROWSER=safari
export EDITOR="nvim"

# Set Path
export PATH="$HOME/bin::/usr/local/bin:/usr/bin:/sbin:/bin:/usr/sbin"
export PATH="$PATH:$HOME/Library/Python/2.7/bin:$HOME/node_modules/.bin"
export PATH="$PATH:/Users/soleblaze/.gem/ruby/2.3.0/bin"

# Set fpath for zsh-completion (homebrew package)
fpath=(/usr/local/share/zsh-completions $fpath)

# Over-ride ls alias
alias ls="ls -CGFh"
#export JAVA_HOME=$(/usr/libexec/java_home)

# Use neovim instead of vim
alias vim="NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim"
alias vi="NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim"

# Setup SSH keys via gpg
export "GPG_TTY=$(tty)"
export "SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh"
