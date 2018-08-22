setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.

HISTORY_IGNORE="([fb]g|ll|lo|h|cl|su|ls|cd|pwd|exit|cd ..)"

function h() {
   #fc -lim "*$@*" 1

    if [ -z "$1" ]
    then
        history 1
    else
        history 1 | grep "$@"
    fi
}
