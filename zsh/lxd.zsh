#!/usr/bin/zsh


function lxcd ()
{
    machine=$1
    if [ "$machine" != "reveng" -a "$machine" != "target-arch" -a "$machine" \
        != "target-ubuntu" ]; then
        lxc delete -i "$machine"
    else
        echo "Error: $machine is a template and should not be destroyed."
    fi
}

function lxcs ()
{
  lxc exec $! -- sudo --user ubuntu --login
}

alias lxcc="lxc copy"
alias lxcfp="lxc file push"
