#!/bin/zsh

# git aliases
alias ga="git add"
alias gac="git commit -a -S"
alias gacm="git commit -a -S -m"
alias gam="git commit -amend"
alias gb="git branch"
alias gc="git commit -S"
alias gcm="git commit -S -m"
alias gd="git diff"
alias gdm="git diff origin/master"
alias gds="git diff --staged"
alias gdt="git difftool"
alias gl="git log --graph --decorate" 
alias gld="git log --all --graph --decorate --oneline --simplify-by-decoration"
alias glg="git log --graph --pretty=format:'%C(auto)%h -%d %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glf='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
alias glp="git log -p --decorate"
alias gm="git merge"
alias gmv="git mv"
alias gp='git push'
alias gpb='git push origin'
alias gpu='git pull'
alias gpub='git pull origin'
alias gr="git rm"
alias grb="git rebase"
alias grh="git reset HEAD"
alias gs="git status -s"

# git functions
function gacmp () {
    git commit -S -a -m "$*" && git push -u origin master
}

function gcmp () {
    git commit -S -m "$*" && git push -u origin master
}
