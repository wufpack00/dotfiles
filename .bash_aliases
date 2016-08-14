# .bash_aliases

#-----------
# Alias
#-----------
alias grep='grep --color=always'
alias du='du -h'
alias df='df -h'
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias more='less'

alias mroe='more'
alias m='more'

alias reload='. $HOME/.bash_profile'
alias ll='ls -FlAhp --color=always'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation

alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias ~="cd ~"                              # ~:            Go Home
alias which='type -all'                     # which:        Find executables

# go up one level and list contents
alias u='clear; cd ..;'  

alias cl='clear'

alias lo='logout'
alias path='echo -e ${PATH//:/\\n}'
alias psj='ps -ef |grep java'
alias numFiles='echo $(ls -1 | wc -l)'
alias vless='/usr/share/vim/vim70/macros/less.sh'
alias view='vi -R'

alias tls='tmux ls'
alias tkw='tmux kill-window'
alias tks='tmux kill-session'
alias msl='mux start default'
alias msd='mux start dev'

alias td='date +"%Y%m%d"'
alias ts='date +"%Y%m%d%H%M%S"'
alias vi='vim'
alias yd='date -d "1 day ago" +"%Y%m%d"'

alias whosthere='netstat -a | grep -v localhost | grep EST | sort -k4,4'
