#!/bin/bash

set -x;

if [ "$#" -ne "1" ] ; then
    echo "Usage: $0 servername" >&2
    exit 2
fi

NEWSERVER=$1

ssh-copy-id $NEWSERVER

rsync -avg --exclude="*cygwin" --exclude="*history" $HOME/.bash* $NEWSERVER:
rsync -avg $HOME/.vimrc $NEWSERVER:

ssh $NEWSERVER "curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> ~/.git-completion.bash; curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh >> ~/.git-prompt.sh"
