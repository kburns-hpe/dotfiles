#!/bin/bash

host="$1"
confdir="$PWD/nvim"


# Setup nvim directory
mkdir -p ~/.config/nvim/{bundle,tmp,backup,colors,ftplugin,UltiSnips} 2>/dev/null
ln -s $confdir/colors/cobalt.vim ~/.config/nvim/colors/cobalt.vim

# Setup init.vim
ln -s "$confdir/init.vim" ~/.config/nvim/init.vim

# Setup vim-plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Setup ftplugin directory
pushd "$confdir"/ftplugin/
for file in *; do 
        ln -s "$confdir"/ftplugin/"$file" ~/.config/nvim/ftplugin/"$file"
done
popd

# Install plugins
vim -c "PlugInstall" -c ":qa"

# Create link for ftdetect puppet
mkdir ~/.config/nvim/ftdetect
ln -s ~/.config/nvim/plugged/vim-puppet/ftdetect/puppet.vim ~/.config/nvim/ftdetect/puppet.vim
