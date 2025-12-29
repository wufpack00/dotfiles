[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

## History command configuration
setopt extended_history   # record timestamp of command in HISTFILE
setopt inc_append_history # add commands to HISTFILE in order of execution

setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt hist_ignore_all_dups   # delete old recorded entry if new entry is a duplicate.
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_save_no_dups      # don't write duplicate entries
#setopt hist_verify            # show command with history expansion to user before running it
setopt share_history # share command history data

HISTORY_IGNORE="([fb]g|ll|lo|h|cl|su|ls|cd|pwd|exit|cd ..)"

function h() {
  #fc -lim "*$@*" 1

  if [ -z "$1" ]; then
    history 1
  else
    history 1 | grep "$@"
  fi
}
