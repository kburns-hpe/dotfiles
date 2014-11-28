#!/usr/bin/zsh

# Anamnesis clipboard manager aliases

alias cl="anamnesis -l 15"
alias cf="anamnesis -l 15 --filter"
alias cb="anamnesis -b"
alias ca="anamnesis -a"
alias cr="anamnesis -r"
alias cclean="anamnesis --cleanup"

# Function to clear all clipboard history
function cclear() {
    entries="$(anamnesis -l 1 | tail -n1 | sed 's/(\([0-9]*\),.*/\1/')"
    for num in {1..$entries}; do
        anamnesis --remove=$num
    done
    anamnesis --cleanup
    echo "Completed removing all clipboard entries in anamesis."
}

