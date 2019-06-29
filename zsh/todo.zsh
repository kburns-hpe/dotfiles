alias t="todo"
alias ta="todo add"
alias td="todo done"
alias tai="todo add Inbox"
alias tl="todo list"
alias tli="todo list project Inbox"
alias tm="todo move"
alias tp="todo projects"

function tll() {
  if [ "$#" -eq 0 ]; then
    todo labels
  else
    todo list label "$*"
  fi
}

function tlp() {
  if [ "$#" -eq 0 ]; then
    todo projects
  else
    todo list project "$*"
  fi
}
