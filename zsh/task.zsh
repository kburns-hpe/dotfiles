#!/bin/zsh

# Task Warrior
alias t="task"
alias ta="t add"
alias tn="t next"
alias tnew="t newest"
alias told="t oldest"
alias tl="t ls"
alias tln="t ls tag:next"
alias tp="t projects"
alias tsum="t summary"
alias th="t history"
alias tcal="t calendar"
alias tod="task overdue"
alias treview="tmux split-window;cd ~/git/thirdparty/gtd; node ./weekly.js;exit"

function td {
        task $1 done
        task sync
}

function tlater {
        task $1 modify +later
        task sync
}
function tdel {
        task $1 delete
        task sync
}

function tap {
        task add project:$*
        task sync
}

function tlp {
        task ls project:$*
}

function tm {
        tasknum=$1
        shift
        task $tasknum modify $*
        task sync
}

function ts {
        task $1 start
}

function tdep {
        task $1 modify depends:"$2"
}

# Autocomplete

zstyle ':completion:*:*:task:*' verbose yes
zstyle ':completion:*:*:task:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:*:task:*' group-name ''
compdef _task t=task
