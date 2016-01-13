#!/bin/bash

host="$1"
confdir="$PWD/zsh"

# Common configurations to all installs
zshconfs="01-zsh-syntax-highlighting alias autocomplete bd bindkeys functions git git-prompt history misc prompt zsh-history-substring-search"

# Cygwin
if [ "$host" = "cygwin" ]; then
    zshconfs="$zshconfs cygwin"

# OSX
elif [ "$host" = "osx" ]; then
    zshconfs="$zshconfs doing osx"

# Arch Linux
elif [ "$host" = "archlinux" ]; then
    zshconfs="$zshconfs archlinux anamnesis doing fasd lxc pinboard task recoll"

# Guest Arch Linux Machine
elif [ "$host" = "archguest" ]; then
    zshconfs="$zshconfs archguest"

# Ubuntu Linux Machine
elif [ "$host" = "ubuntu" ]; then
    zshconfs="$zshconfs ubuntu"
fi

# Create symlinks for zsh configs
ln -s "$confdir/zshrc" ~/.zshrc
mkdir -p ~/.zsh 2>/dev/null

# Create symlink for git-prompt python script
ln -s "$confdir/gitstatus.py" ~/.zsh/gitstatus.py

for conf in $zshconfs; do
    ln -s "$confdir/$conf.zsh" ~/.zsh/"$conf.zsh"
done

# Create links for completions
mkdir -p ~/.zsh/completion
completions="_doing.zsh _task"
for completion in $completions; do
    ln -s "$confdir/completion/$completion" ~/.zsh/completion/$completion
done
