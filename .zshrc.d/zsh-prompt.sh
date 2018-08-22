autoload -U colors && colors

setopt PROMPT_SUBST     # allow funky stuff in prompt
precmd () { 
   color="green"
   if [ "$USER" = "root" ]; then
      color="red"         
   fi;

   GIT_PS1_SHOWDIRTYSTATE=true

   local gitcolor="cyan"

   # include git branch name in prompt
   if [[ "$(__git_ps1)" =~ "\*\)"$ ]] ; then
   # a file has been modified but not added
	   gitcolor="yellow"
   elif [[ "$(__git_ps1)" =~ "\+\)"$ ]] ; then
      # a file has been added, but not commited
	   gitcolor="magenta"
   fi

   local PROMPT_COLOR="%{$fg[$color]%}"
   local GIT_COLOR="%{$fg[$gitcolor]%}"
   local ORANGE="$FG[202]"
   local FINAL="%{$reset_color%}"

#PROMPT=$PROMPT_COLOR'[%n@%m:'$ORANGE'%~'$PROMPT_COLOR$GIT_COLOR'$(__git_ps1 " (%s)")'$PROMPT_COLOR'] '$FINAL
   
   __git_ps1 $PROMPT_COLOR"[%n@%m:"$ORANGE"%~"$GIT_COLOR $PROMPT_COLOR"] "$FINAL " (%s)"

}
