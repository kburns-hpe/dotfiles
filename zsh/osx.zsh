#!/bin/zsh

# Set Variables
export BROWSER=safari
export EDITOR=vim

# Set Path
export PATH="$HOME/bin::/usr/local/bin:/usr/bin:/sbin:/bin:/usr/sbin"
export PATH="$PATH:~/.chefdk/gem/ruby/2.1.0/bin"

# Set fpath for zsh-completion (homebrew package)
fpath=(/usr/local/share/zsh-completions $fpath)

# Over-ride ls alias
alias ls="ls -CGFh"
#export JAVA_HOME=$(/usr/libexec/java_home)
