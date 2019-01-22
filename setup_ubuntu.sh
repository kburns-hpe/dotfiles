#!/bin/bash
set -eu
set -o pipefail

packages="
clang
file
golang
jq
mosh
neovim
nodejs
npm
python-dev
python-pip
python3-dev
python3-pip
silversearcher-ag
strace
tmux
weechat
wget
zsh
"

# Install packages
echo $packages | xargs sudo apt-get install -y

# Install gitbatch
go get -u github.com/isacikgoz/gitbatch

# Install python modules
pip install neovim
pip3 install neovim

# Run install scripts
./setup_zsh.sh ubuntu
./setup_tmux.sh
./setup_git_global_hooks.sh
./setup_nvim.sh

# Install vim-go binaries
nvim -c ":GoInstallBinaries" -c ":qa"
