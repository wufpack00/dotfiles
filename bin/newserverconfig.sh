#!/bin/bash

readonly BOOT_CMD="./dotfiles/bin/bootstrap.sh -w"
set -x;

if [ "$#" -ne "1" ] ; then
    echo "Usage: $0 servername" >&2
    exit 2
fi

NEWSERVER=$1

ssh-copy-id $NEWSERVER

if $(ssh $NEWSERVER "command -v git&> /dev/null"); then
    #echo "git installed"
    ssh $NEWSERVER "git clone https://github.com/wufpack00/dotfiles.git; $BOOT_CMD"
else

    #echo "git not installed"
    ssh $NEWSERVER "wget https://github.com/wufpack00/dotfiles/archive/master.zip;unzip master.zip; mv dotfiles-master dotfiles; rm master.zip; $BOOT_CMD"
fi

ssh $NEWSERVER "curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> ~/.git-completion.bash; curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh >> ~/.git-prompt.sh"
