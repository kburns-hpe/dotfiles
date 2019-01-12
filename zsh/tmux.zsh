if [ -z "$TMUX" ] && [ -e "$HOME/.tmux.conf" ]; then
  ssh_client_ip="$(echo $SSH_CLIENT | awk '{print $1}' | tr "." "_")"
  session_name="${ssh_client_ip:=localhost}"
    # Create a new session if it doesn't exist
    tmux has-session -t $session_name || tmux new-session -d -s $session_name
    tmux attach-session -t $session_name
fi
