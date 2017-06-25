#!/bin/bash
hook_dir="$PWD/git-hooks"
mkdir ~/.git_template
ln -s "$hook_dir" ~/.git_template/hooks

git config --global init.templatedir '~/.git_template'
git config --global alias.ctags '!.git/hooks/ctags'
