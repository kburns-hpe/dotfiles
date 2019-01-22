#!/bin/bash

confdir="$PWD/tmux"

# Setup tmux
ln -s "$confdir/tmux.conf" ~/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
