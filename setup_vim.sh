#!/bin/bash

host="$1"
confdir="$PWD/vim"

# Setup vimrc
ln -s "$confdir/vimrc" ~/.vimrc

# Setup .vim directory
mkdir -p ~/.vim/{bundle,tmp,backup,colors,ftplugin,UltiSnips} 2>/dev/null
ln -s $confdir/outline.vimrc ~/.vim/outline.vimrc
ln -s $confdir/colors/cobalt.vim ~/.vim/colors/cobalt.vim

# Setup vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Setup ftplugin directory
pushd "$confdir"/ftplugin/
for file in *; do 
        ln -s "$confdir"/ftplugin/"$file" ~/.vim/ftplugin/"$file"
done
popd

# Install plugins
vim -c "BundleInstall" -c ":qa"

# Create link for nvim script
ln -s ~/.vim/bundle/nvim/nvim ~/bin/nvim

# Create link for ftdetect puppet
mkdir ~/.vim/ftdetect
ln -s ~/.vim/bundle/vim-puppet/ftdetect/puppet.vim ~/.vim/ftdetect/puppet.vim
