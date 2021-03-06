# ssh-completion.sh 

# ssh auto-complete from known_hosts file
if [ -f "${HOME}/.ssh/known_hosts" ]; then
    complete -W "$(echo `cat ${HOME}/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
fi

