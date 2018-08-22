
if [ -f "${HOME}/.tmux/bash_completion_tmux.sh" ]; then
  # https://github.com/Bash-it/bash-it/blob/master/completion/available/tmux.completion.bash
  source "${HOME}/.tmux/bash_completion_tmux.sh"
fi

if [ -f "${HOME}/.tmuxinator/tmuxinator.bash" ]; then
    # https://github.com/tmuxinator/tmuxinator
    source "${HOME}/.tmuxinator/tmuxinator.bash"
fi

#--------------------------
# Start Mux Session
#--------------------------
if is_windows && command_exists tmuxinator && command_exists ruby && [ -f "${HOME}/.tmuxinator/default.yml" ] ; then
    # on macos we use iterm2 with tmux integration instead
    tmuxinator start default
fi
