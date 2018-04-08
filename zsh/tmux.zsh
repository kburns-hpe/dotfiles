if [ -z "$TMUX" ]; then
    base_session='initial'
    # Create a new session if it doesn't exist
    tmux has-session -t $base_session || tmux new-session -d -s $base_session
    # Are there any clients connected already?
    client_cnt=$(tmux list-clients | wc -l)
    if [ $client_cnt -ge 1 ]; then
        session_name=$base_session"-"$client_cnt
        tmux new-session -d -t $base_session -s $session_name
        tmux attach-session -t $session_name \; set-option destroy-unattached
    else
        tmux attach-session -t $base_session
    fi
fi
