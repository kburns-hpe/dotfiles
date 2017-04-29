#!/usr/bin/zsh

# Fix keyboard after lxc starts
alias fixkb="killall xcape;setxkbmap -option terminate:ctrl_alt_bksp; xmodmap ~/.Xmodmap; xcape -e 'Control_R=Escape;Super_R=Tab'"

funciton lxcs () {
    sudo lxc-start -n $1 -d
    echo "Fixing keyboard..."
    killall xcape
    sleep 5 && setxkbmap -option terminate:ctrl_alt_bksp; xmodmap ~/.Xmodmap; xcape -e 'Control_R=Escape;Super_R=Tab'
}

alias lxcstop="sudo lxc-stop -n"
alias lxcls="sudo lxc-ls -f"

function lxcc ()
{
    machine=$1
    clone=$2

    if [ -d "/var/lib/lxc/$machine" ]; then
        if [ "$clone" ]; then
            sudo lxc-copy -n "$machine" -N "$clone" -s btrfs
            sudo sed -i -e 's|\(^lxc.mount.entry.*/var/lib/lxc/\)'$machine'|\1'$clone\| "/var/lib/lxc/$clone/config"
        else
            echo "Error: Clone machine name not specified"
        fi
    else
        echo "$machine is not a valid lxc container"
    fi
}

function lxcd ()
{
    machine=$1
    if [ "$machine" != "tools" -a "$machine" != "target-arch" -a "$machine" \
        != "target-ubuntu" ]; then
        sudo lxc-destroy -n $machine
    else
        echo "Error: $machine is a template and should not be destroyed."
    fi
}
