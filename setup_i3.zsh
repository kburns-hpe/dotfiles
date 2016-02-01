#!/bin/bash

host="$1"
confdir="$PWD/i3"
mkdir -p ~/.config/i3

# Link files
ln -s "${confdir}/config" ~/.config/i3/config
ln -s "${confdir}/pacvol.sh" ~/.config/i3/pacvol.sh
ln -s "${confdir}/i3blocks/scripts" ~/.config/blocks
cp "${confdir}/i3blocks/i3blocks.conf ~/.i3blocks.conf
