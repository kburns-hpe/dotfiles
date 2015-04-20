#!/bin/zsh

# Find shortcuts
function findi() {
    find . -iname "*${1}*"
  }


# Use imagemagik to convert colors
function convertcolor() {
        convert $3 -colorspace gray -auto-level +level-colors "${1},${2}" $3
}

# Strip comments and empty lines out of a file
function catnc() {
    egrep -v '(^#|^/)' "$1" | sed '/^$/d'
}

# Renames tmux window to server ssh is being used to connect to
function ssh() {
  if [ -n "$TMUX" ] # set only if within running tmux
  then
    window_index=$(tmux display-message -p '#I')

    # arbitrary environment variable name to remember ssh args like server
    # hostname so we can connect again.
    session_variable_name="window_${window_index}_ssh_args"

    # save in tmux session variable
    tmux setenv $session_variable_name "${@[-1]}"

    # set window title
    tmux rename-window ${@[-1]}

    # run ssh
    /usr/bin/ssh $*

    # unset variable so new panes don't continue ssh-ing to this server
    tmux setenv -u $session_variable_name
  else
    /usr/bin/ssh $*
  fi

  # rename title back
  tmux rename-window zsh
}

# Renames tmux window to server ssh is being used to connect to
# Doesn't save key in known_hosts
function sshnh() {
  if [ -n "$TMUX" ] # set only if within running tmux
  then
    window_index=$(tmux display-message -p '#I')

    # arbitrary environment variable name to remember ssh args like server
    # hostname so we can connect again.
    session_variable_name="window_${window_index}_ssh_args"

    # save in tmux session variable
    tmux setenv $session_variable_name "${@[-1]}"

    # set window title
    tmux rename-window ${@[-1]}

    # run ssh
    /usr/bin/ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null" $*

    # unset variable so new panes don't continue ssh-ing to this server
    tmux setenv -u $session_variable_name
  else
    /usr/bin/ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null" $*
  fi

  # rename title back
  tmux rename-window zsh
}
