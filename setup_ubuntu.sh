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

ripgrep="https://github.com/BurntSushi/ripgrep/releases/download/0.8.0/ripgrep-0.8.0-x86_64-unknown-linux-musl.tar.gz"


# Install packages
echo $packages | xargs sudo apt-get install -y

# Download ripgrep
mkdir ~/bin ~/tmp
wget -O ~/tmp/ripgrep.tgz "$ripgrep"
pushd ~/tmp
tar xf ripgrep.tgz --strip-components=1
mv rg ~/bin
popd
rm -rf ~/tmp

# Install nodejs packages
sudo npm install -g diff-so-fancy

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
