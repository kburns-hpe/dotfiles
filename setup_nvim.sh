#!/bin/bash

confdir="$PWD/nvim"

# Setup nvim directory
mkdir -p ~/.config/nvim/{bundle,tmp,backup,colors,ftplugin} 2>/dev/null
mkdir -p ~/.config/nvim/autoload/lightline/colorscheme
ln -s "$confdir"/autoload/lightline/colorscheme/cobalt2.vim ~/.config/nvim/autoload/lightline/colorscheme

# Setup init.vim
ln -s "$confdir/init.vim" ~/.config/nvim/init.vim
ln -s "$confdir/unix.vim" ~/.config/nvim/unix.vim
ln -s "$confdir/tmux.vim" ~/.config/nvim/tmux.vim
ln -s "$confdir/init" ~/.config/nvim/init

# Setup vim-plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Setup ftplugin directory
pushd "$confdir"/ftplugin/ || exit
for file in *; do
        ln -s "$confdir"/ftplugin/"$file" ~/.config/nvim/ftplugin/"$file"
done
popd || exit

# Setup UltiSnips directory
ln -s "$confdir"/UltiSnips ~/.config/nvim/UltiSnips

# Install plugins
nvim +PlugInstall +UpdateRemotePlugins +qa
