# ~/.bashrc: executed by bash(1) for interactive shells.

PAGER='less -i'


# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

export EDITOR='vim'

PATH=$(echo -n $PATH | awk -v RS=: -v ORS= '!a[$0]++ {if (NR>1) printf(":"); printf("%s", $0) }' )
export PATH

unset USERNAME
