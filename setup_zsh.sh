#!/bin/bash

host="$1"
confdir="$PWD/zsh"

# Create symlinks for zsh configs
ln -s "$confdir/zshrc" ~/.zshrc
touch ~/.zshrc_local
