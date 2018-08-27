if [ -f "$HOME/.bash.local" ]; then
    source "$HOME/.bash.local"
fi

# .bash_work

#--------------
# Server names by environment
#--------------
PROD_SERVERS="prod01 prod02 prod03"
DR_SERVERS="dr01 dr02"
SANDBOX_SERVERS="sb01 sb02"
UIT_SERVERS="uit01 uit02"
STAGE_SERVERS="st01 st02"
TEST_SERVERS="test01 test02"
DEV_SERVERS="dev01 dev02"

THISHOST=$(hostname -s 2> /dev/null)
if [ -z "$THISHOST" ] ; then
    # try without the s option since gnu coreutils (used by github4windows) doesn't support it
    THISHOST=$(hostname)
fi

#--------------
# Color command prompt based on environment
#--------------

# determine server environment by either defined list or starts-with naming convention
if [[ $UIT_SERVERS == *"$THISHOST"* ]] || [[ $THISHOST == ncu* ]] ; then
    # prompts in uit are purple
    PROMPT_COLOR=$MAGENTA
elif [[ $PROD_SERVERS == *"$THISHOST"* ]] || [[ $THISHOST == ncp* ]] ; then
    # prompts in prod are red
    PROMPT_COLOR=$RED
elif [[ $SANDBOX_SERVERS == *"$THISHOST"* ]] || [[ $THISHOST == sb* ]] ; then
    # prompts in sandbox are yellow
    PROMPT_COLOR=$YELLOW
elif [[ $THISHOST == az* ]] ; then
    # prompts in sandbox are light blue
    PROMPT_COLOR=$CYAN
elif [[ $THISHOST == *CROGERS* ]] ; then
    # prompts in localhost are green
    PROMPT_COLOR=$GREEN
else
    # no color in dev environments
    PROMPT_COLOR=$LIGHT_GRAY
fi

#-----------
# Environment Variables
#-----------
export CDPATH='.:/home/www'
PATH=$PATH:/usr/local/tools/bin:/home/www/bin

#-----------
# SSH Alias
#-----------
alias sshb='ssh servername'

alias sutomcat='sudo su - tomcat'


#-----------------
# server specific
#-----------------
TOMCAT_LOGDIR="home/logs/tomcat"
TOMCAT_LOGFILE="apps"

alias www='cd /home/www'
alias webinf='cd /home/www/webapps/apps/WEB-INF'
alias tat='cd $TOMCAT_LOGDIR; tail -f $TOMCAT_LOGFILE.$(td)'
alias tam='cd $TOMCAT_LOGDIR; more $TOMCAT_LOGFILE.$(td)'
alias logs='cd $TOMCAT_LOGDIR'
alias rt='/usr/local/bin/tomcatctl restart && tail -f $TOMCAT_LOGDIR/$TOMCAT_LOGFILE.$(td)'
alias dumpit='/usr/local/bin/dumptomcat >> ~/tomcatdump.$(hostname -s).$(ts).log'


# for loops on remote servers
# example: forssh "cd /home/logs/tomcat; for j in 23 24 25 ; do ls apps*$j*; done " ; done
# 		   forssh "grep PONumber /home/logs/tomcat/messages/OrgPOExport/Request*20100910*" ; done
#		   forssh "grep crogers /home/logs/tomcat/apps.$(today)" >> file && echo $i >> file ; done
# example: forloop scp $i:/home/www/properties/sqlocal.properties ./$i-sqlocal.properties;done
#          forloopr cat .ssh/id_rsa.pub | ssh $i 'cat >> .ssh/authorized_keys'; done
alias forloop='for i in $PROD_SERVERS; do '
alias forssh='for i in $PROD_SERVERS; do echo $i; ssh -q $i '
alias forloopdr='for i in $DR_SERVERS; do '
alias forsshdr='for i in $DR_SERVERS; do echo $i; ssh -q $i'
alias forloops='for i in $SANDBOX_SERVERS; do '
alias forsshs='for i in $SANDBOX_SERVERS; do echo $i; ssh -q $i '
alias forloopu='for i in $UIT_SERVERS; do '
alias forsshu='for i in $UIT_SERVERS; do echo $i; ssh -q $i '
alias forloopr='for i in $STAGE_SERVERS; do '
alias forsshr='for i in $STAGE_SERVERS; do echo $i; ssh -q $i '
alias forssht='for i in $TEST_SERVERS; do echo $i; ssh -q $i '
alias forsshd='for i in $DEV_SERVERS; do echo $i; ssh -q $i '

#start/stop/status of services on remote servers
svcstop () { curl -d ParamAction=stop http://"$@"/apps/Router/ServiceManagement ; }
svcstart () { curl -d ParamAction=start http://"$@"/apps/Router/ServiceManagement ; }
svcstatus () { curl -d ParamAction=status http://"$@"/apps/Router/ServiceManagement ; }

gtat() { cd $TOMCAT_LOGDIR; tail -f $TOMCAT_LOGFILE.$(td) | grep "$@" ; }
gta() { cd $TOMCAT_LOGDIR; grep "$@" $TOMCAT_LOGFILE.$(td); }
gya() { cd $TOMCAT_LOGDIR; grep "$@" $TOMCAT_LOGFILE.$(yd); }
fileversion() { /bin/grep "$@" /home/www/webapps/apps/WEB-INF/filelist;}
