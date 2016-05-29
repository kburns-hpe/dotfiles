#!/bin/bash

host="$1"
confdir="$PWD/awesome"

mkdir -p ~/.config/awesome/images 2>/dev/null
mkdir -p ~/.config/awesome/scripts 2>/dev/null
mkdir -p ~/.config/awesome/themes 2>/dev/null
mkdir -p ~/.fonts 2>/dev/null

# Link fonts
ln -s "$confdir/fonts/BITSUMIS.TTF" ~/.fonts/BITSUMIS.TTF
ln -s "$confdir/fonts/CGF Locust Resistance.ttf" ~/.fonts/"CGF Locust Resistance.ttf"
fc-cache

# Link main configurations
pushd "$confdir"
for file in bindings eminent menu notification rc rules signals tags tasklist widgets; do
    ln -s "$confdir/$file.lua" ~/.config/awesome/$file.lua
done

# Copy config file
cp "$confdir/config.lua" ~/.config/awesome/config.lua

# Link themes
pushd "$confdir/themes"
for file in *.lua; do
    ln -s "$confdir/themes/$file" ~/.config/awesome/themes/"$file"
done
popd

# Link scripts
pushd "$confdir/scripts"
for file in *.lua; do
    ln -s "$confdir/themes/$file" ~/.config/awesome/themes/"$file"
done
popd

# Link images
for image in $(cd "$confdir/images"; ls); do
    ln -s "$confdir/images/$image" ~/.config/awesome/images/$image
done
