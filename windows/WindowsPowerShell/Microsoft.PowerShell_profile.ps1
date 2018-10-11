Import-Module posh-git
Import-Module oh-my-posh
Import-Module Get-ChildItemColor
Import-Module z

Start-SshAgent
Set-Theme sb

$PSDefaultParameterValues['Install-Module:Scope'] = 'CurrentUser'

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-Alias ls Get-ChildItemColorFormatWide -option AllScope
Set-Alias ll Get-ChildItemColor -option AllScope

Set-Alias g git
function Git-Add { git add $args }
Set-Alias ga Git-Add
function Git-Add-Commit { git commit -a $args }
Set-Alias gac Git-Add-Commit

function Git-Add-Commit-Comment { git commit -am $args }
Set-Alias gacm Git-Add-Commit-Comment

function Git-Amend { git commit -amend $args }
Set-Alias gap Git-Ammend

function Git-Add-Partial { git add -p $args }
Set-Alias gap Git-Add-Partial

function Git-Branch { git branch $args }
Set-Alias gb Git-Branch

function Git-Commit { git commit $args }
Set-Alias gac Git-Commit

function Git-Checkout-Branch { git checkout -b $args }
Set-Alias gcb Git-Checkout-Branch

function Git-Checkout { git checkout $args }
Set-Alias gch Git-Checkout

function Git-Diff { git diff $args }
Set-Alias gd Git-Diff

function Git-Diff-Master { git diff origin/master $args }
Set-Alias gdm Git-Diff-Master

function Git-Diff-Staged { git diff --staged $args }
Set-Alias gds Git-Diff-Staged

function Git-Diff-Tool { git difftool $args }
Set-Alias gdt Git-Diff-Tool

function Git-Log { git log --graph --decorate $args }
Set-Alias glog Git-Log

function Git-Log-Decorate { git log --all --graph --decorate --oneline --simplify-by-decoration $args }
Set-Alias gld Git-Log-Decorate

function Git-Log-Graph { git log --graph --pretty='format:%C(auto)%h -%d %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit $args }
Set-Alias glg Git-Log-Graph

function Git-Log-Files { git log --pretty='format:%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate --numstat $args }
Set-Alias glf Git-Log-Files

function Git-Log-Path { git log -p --decorate $args }
Set-Alias glp Git-Log-Path

function Git-Move { git mv $args }
Set-Alias gmv Git-Move

function Git-Push { git push origin HEAD }
Set-Alias gpush Git-Push

function Git-Push-Origin { git push origin }
Set-Alias gpo Git-Push-Origin

function Git-Pull-Origin-Head { git pull origin HEAD }
Set-Alias gpu Git-Pull-Origin-Head

function Git-Remove { git rm $args }
Set-Alias gr Git-Remove

function Git-Rebase { git rebase $args }
Set-Alias gr Git-Rebase

function Git-Reset { git reset HEAD }
Set-Alias grh Git-Reset

Function Git-Status { git status -s }
Set-Alias gs Git-Status