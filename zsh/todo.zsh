alias t="todo.py"
alias ta="todo.py add"
alias td="todo.py done"
alias tai="todo.py add Inbox"
alias tl="todo.py list"
alias tp="todo.py projects"

function tll() {
  if [ "$#" -eq 0 ]; then
    todo.py labels
  else
    todo.py list label "$*"
  fi
}

function tlp() {
  if [ "$#" -eq 0 ]; then
    todo.py projects
  else
    todo.py list project "$*"
  fi
}
