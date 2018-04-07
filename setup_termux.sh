#!/bin/bash
set -eu
set -o pipefail

packages="
clang
curl
file
fzf
golang
grep
jq
mosh
ncurses-utils
neovim
nodejs
python
python-dev
python2
python2-dev
proot
radare2
ruby
silversearcher-ag
strace
tar
tmux
weechat
wget
zsh
"

ripgrep="https://github.com/BurntSushi/ripgrep/releases/download/0.8.0/ripgrep-0.8.0-x86_64-unknown-linux-musl.tar.gz"


# Install packages
echo $packages | xargs pkg install -y

# Download ripgrep
mkdir ~/bin ~/tmp
wget -O ~/tmp/ripgrep.tgz "$ripgrep"
pushd ~/tmp
tar xf ripgrep.tgz --strip-components=1
mv rg ~/bin
popd
rm -rf ~/tmp

# Install nodejs packages
npm install -g diff-so-fancy

# Install python modules
pip install neovim
pip2 install neovim

# Install ruby modules
gem install bundler rubocop

# Run install scripts
./setup_zsh.sh
./setup_tmux.sh
./setup_git_global_hooks.sh
./setup_nvim.sh

# Install vim-go binaries
nvim -c ":GoInstallBinaries" -c ":qa"

# Install exercism
go get github.com/exercism/cli/exercism
pushd ~/go/src/github.com/exercism/cli
git checkout master
popd
go install github.com/exercism/cli/exercism

# Setup zsh-you-should-use plugin
cd ~/git
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git
ln -s ~/git/zsh-you-should-use/you-should-use.plugin.zsh ~/.zsh/you-should-use.plugin.zsh
