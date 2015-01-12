#!/bin/zsh

# Load fasd
eval "$(fasd --init auto)"

# any
alias fa='fasd -a'
# show / search  / selectk
alias fs='fasd -si'
# directory
alias fd='fasd -d'
# file
alias ff='fasd -f'
# interactive directory selection
alias fsd='fasd -sid'
# interactive file selection
alias fsf='fasd -sif'
# cd
alias z='fasd_cd -d'
# interactive cd
alias zz='fasd_cd -d -i'
