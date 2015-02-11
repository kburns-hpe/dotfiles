#!/bin/zsh

# git aliases
alias ga="git add"
alias gac="git commit -a"
alias gacm="git commit -a -m"
alias gam="git commit -amend"
alias gb="git branch"
alias gc="git commit"
alias gcm="git commit -m"
alias gd="git diff"
alias gdm="git diff origin/master"
alias gds="git diff --staged"
alias gdt="git difftool"
alias gl="git log"
alias glp="git log -p"
alias gm="git merge"
alias gmv="git mv"
alias gp='git push -u origin master'
alias gpb='git push -u origin'
alias gpu='git pull -u origin master'
alias gpub='git pull -u origin'
alias gr="git rm"
alias grb="git rebase"
alias grh="git reset HEAD"
alias gs="git status -s"

# git functions
function gacmp () {
    git commit -a -m "$*" && git push -u origin master
}

function gcmp () {
    git commit -m "$*" && git push -u origin master
}
