#!/bin/bash
hook_dir="$PWD/git-hooks"
mkdir ~/.git_template
ln -s "$hook_dir" ~/.git_global_hooks

git config --global core.hooksPath '~/.git_global_hooks'
git config --global alias.ctags '!.git/hooks/ctags'
