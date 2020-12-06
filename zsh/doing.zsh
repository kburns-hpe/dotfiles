#!/bin/zsh

# Doing Aliases
# https://github.com/ttscoff/doing

alias dn="doing now"
alias ddone="doing done"
alias dl="doing later"
alias dnext="doing done; doing now"
alias dt="doing today --totals | colout '^([ \d:apm]+) ?([>:]) (.*)' green,black,white"
alias dy="doing yesterday --totals | colout '^([ \d:apm]+) ?([>:]) (.*)' green,black,white"
