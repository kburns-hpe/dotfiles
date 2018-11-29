#!/bin/bash
hook_dir="$PWD/git-hooks"
mkdir ~/.git_global_hooks

pushd $hook_dir
for hook in *; do
  ln -s "$hook_dir/$hook" ~/.git_global_hooks/"$hook"
done
popd

git config --global core.hooksPath '~/.git_global_hooks'
git config --global alias.ctags '!.git/hooks/ctags'
