#!/bin/zsh

# Set Variables
export BROWSER=safari
export EDITOR="nvim"

# Set Path
export PATH="$HOME/bin::/usr/local/bin:/usr/bin:/sbin:/bin:/usr/sbin"
export PATH="$PATH:$HOME/node_modules/.bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:/Users/soleblaze/.gem/ruby/2.6.0/bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Set fpath for zsh-completion (homebrew package)
fpath=(/usr/local/share/zsh-completions $fpath)


# Use neovim instead of vim
alias vim="nvim"
alias vi="nvim"

# Use ctags installed via brew instead of xcode
alias ctags="/usr/local/bin/ctags"

# Setup SSH keys via gpg
# export "GPG_TTY=$(tty)"
# export "SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh"

# Disable homebrew git token request
export HOMEBREW_NO_GITHUB_API=TRUE


# Launch gpg-agent if it isn't running
# if ! pgrep -q gpg-entry; then
#   gpgconf --launch gpg-agent
# fi
# export SSH_AUTH_SOCKET=$HOME/.gnupg/S.gpg-agent.ssh

