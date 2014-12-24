#!/bin/bash

host="$1"
confdir="$PWD/tmux"

# Setup tmux
ln -s "$confdir/tmux.conf" ~/.tmux.conf
