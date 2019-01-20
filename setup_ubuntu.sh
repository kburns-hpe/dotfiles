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

# Install nodejs packages
sudo npm install -g diff-so-fancy

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

# Install exercism
cd /tmp
wget https://github.com/exercism/cli/releases/download/v2.4.1/exercism-linux-64bit.tgz
pushd /tmp
tar xf exercism-linux064bit.tgz
mv exercism ~/bin
popd

# Setup zsh-you-should-use plugin
cd ~/git
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git
ln -s ~/git/zsh-you-should-use/you-should-use.plugin.zsh ~/.zsh/you-should-use.plugin.zsh
