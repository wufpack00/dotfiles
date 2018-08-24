# ~/.bashrc: executed by bash(1) for interactive shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

PAGER='less -i'


#--------------------------
# Shell Options
#--------------------------
# See man bash for more options...
#
# Don't wait for job termination notification
set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

#--------------------------
# Completion options
#--------------------------
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# [[ -f /etc/bash_completion ]] && . /etc/bash_completion

#--------------------------
# History Options
#--------------------------
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


#--------------------------
# Colored Man Pages
#--------------------------
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode - red
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode - bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode    
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode - yellow
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode - cyan

#--------------------------
# Colors
#--------------------------
RED="\[\033[0;31m\]"
MAGENTA="\[\033[0;35m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[0;36m\]"
GREEN="\[\033[0;32m\]"
function EXT_COLOR () { echo -ne "\[\033[38;5;$1m\]"; }
ORANGE=`EXT_COLOR 172`

# default prompt color
if [[ $EUID -eq 0 ]]; then
    export PROMPT_COLOR=$RED 
else
    export PROMPT_COLOR=$GREEN
fi

#-----------
# Work specific config
#-----------
if [ -f "${HOME}/.bash_work" ]; then
    source "${HOME}/.bash_work"
fi

#--------------------------
# Command Prompt
#--------------------------
if [ -f "${HOME}/.bash_prompt" ]; then
  source "${HOME}/.bash_prompt"
fi

#--------------------------
# Aliases
#--------------------------
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

#--------------------------
# Auto-complete
#--------------------------
if [ -f "${HOME}/.bash_completion" ]; then
  source "${HOME}/.bash_completion"
fi

if [ -f "${HOME}/.tmux/bash_completion_tmux.sh" ]; then
  # https://github.com/Bash-it/bash-it/blob/master/completion/available/tmux.completion.bash
  source "${HOME}/.tmux/bash_completion_tmux.sh"
fi

if [ -f "${HOME}/.tmuxinator/tmuxinator.bash" ]; then
    # https://github.com/tmuxinator/tmuxinator
    source "${HOME}/.tmuxinator/tmuxinator.bash"
fi
#-----------
# MacOS-specific
#-----------
if [ -f "${HOME}/.bash_macosx" ]; then
    source "${HOME}/.bash_macosx"
fi

#-----------
# Cygwin-specific
#-----------
if [ -f "${HOME}/.bash_cygwin" ]; then
    source "${HOME}/.bash_cygwin"
fi

#--------------------------
# Functions
#--------------------------
if [ -f "${HOME}/.bash_functions" ]; then
  source "${HOME}/.bash_functions"
fi

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

#--------------------------
# Environment variables
#--------------------------
if [ -f "${HOME}/bin/aws_switch" ]; then
    # set variables for default profile
    $(${HOME}/bin/aws_switch)
fi

export EDITOR='vim'

PATH=$(echo -n $PATH | awk -v RS=: -v ORS= '!a[$0]++ {if (NR>1) printf(":"); printf("%s", $0) }' )
export PATH

unset USERNAME

#--------------------------
# Start Mux Session
#--------------------------
if is_windows && command_exists tmuxinator && command_exists ruby && [ -f "${HOME}/.tmuxinator/default.yml" ] ; then
    # on macos we use iterm2 with tmux integration instead
    tmuxinator start default
fi

#------------------
# python
#------------------
if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
# activate virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/git-checkouts
source /usr/local/bin/virtualenvwrapper.sh

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# create commands to override pip restriction.
# use `gpip` or `gpip3` to force installation of
# a package in the global python environment
gpip2(){
   PIP_REQUIRE_VIRTUALENV="" pip2 "$@"
}
gpip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}
eval "$(direnv hook bash)"
fi
