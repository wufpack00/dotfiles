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
