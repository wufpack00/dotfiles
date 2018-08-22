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

#--------------------------
# Colorized Prompt
#--------------------------
# default prompt color
if [[ $EUID -eq 0 ]]; then
    export PROMPT_COLOR=$RED 
else
    export PROMPT_COLOR=$GREEN
fi

	GIT_PS1_SHOWDIRTYSTATE=true

	# include git branch name in prompt
	export PS1=$PROMPT_COLOR"[\u@\h:"$ORANGE"\w"'$(
    	if [[ $(__git_ps1) =~ \*\)$ ]] ; then
       	 	# a file has been modified but not added
       	 	echo "'$YELLOW'"$(__git_ps1 " (%s)")
    	elif [[ $(__git_ps1) =~ \+\)$ ]] ; then
       	 	# a file has been added, but not commited
       	 	echo "'$MAGENTA'"$(__git_ps1 " (%s)")
    	else
    		# the state is clean, changes are commited
       	 	echo "'$CYAN'"$(__git_ps1 " (%s)")
    	fi)'$PROMPT_COLOR"""] $LIGHT_GRAY" 

PS1='$(show_virtual_env)'$PS1
