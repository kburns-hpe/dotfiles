export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export GPG_AGENT_INFO="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent"
echo "UPDATESTARTUPTTY" | gpg-connect-agent
