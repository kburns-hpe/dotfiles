REPO=${PWD}
ST_VERSION="0.8.1"

# Install prereqs for st
sudo apt-get install -y build-essential libxft-dev libx11-dev wget

mkdir /tmp/st
pushd /tmp/st
wget https://dl.suckless.org/st/st-${ST_VERSION}.tar.gz
tar xf st-${ST_VERSION}.tar.gz
cd st-${ST_VERSION}
cp "${REPO}/misc/config.h" .
sudo make clean install

# Setup zsh
echo '#!/usr/bin/bash -l\nzsh' > ~/.bashrc
ln -s "${REPO}/zsh/zshrc" ~/.zshrc

# Setup neovim
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 55F96FCF8231B6DD
echo 'deb http://ppa.launchpad.net/neovim-ppa/stable/ubuntu xenial main' > /etc/apt/sources.list.d/neovim.list
sudo apt-get update
sudo apt-get install neovim python2 python3 ruby
gem install --user neovim
pip install --user neovim
pip3 install --user neovim
./setup_nvim.sh

# Setup Simple Terminal App Launcher
sudo cp "${REPO}/misc/debian-st.desktop /usr/share/applications"
sudo curl -o /usr/share/icons/hicolor/48x48/apps/term-icon.png http://icons.iconarchive.com/icons/kxmylo/simple/512/utilities-terminal-icon.png

# Install extra apps
sudo apt-get install -y mosh
