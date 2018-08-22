#--------------------------
# History Options
#--------------------------
# Make bash append rather than overwrite the history on disk
shopt -s histappend

# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:lo:h:cl:la:su:ll' 
#
# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND='history -a; echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD/#$HOME/~}\007";'

# Display date/time command was executed
export HISTTIMEFORMAT=': %Y-%m-%d_%H:%M:%S; '

# Limit number of entries to keep
export HISTSIZE=1000

function h() {
    if [ -z "$1" ]
    then
        history
    else
        history | grep "$@"
    fi
}
