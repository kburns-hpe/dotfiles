#!/bin/zsh

# Set Variables
export BROWSER=safari
export EDITOR="NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim"

# Set Path
export PATH="$HOME/bin::/usr/local/bin:/usr/bin:/sbin:/bin:/usr/sbin"
export PATH="$PATH:$HOME/.chefdk/gem/ruby/2.1.0/bin:$HOME/.gem/ruby/2.0.0/bin:$HOME/node_modules/.bin"

# Set fpath for zsh-completion (homebrew package)
fpath=(/usr/local/share/zsh-completions $fpath)

# Over-ride ls alias
alias ls="ls -CGFh"
#export JAVA_HOME=$(/usr/libexec/java_home)

# Use neovim instead of vim
alias vim="NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim"
alias vi="NVIM_TUI_ENABLE_TRUE_COLOR=1 nvim"
