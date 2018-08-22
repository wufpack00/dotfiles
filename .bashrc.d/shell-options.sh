#--------------------------
# Shell Options
#--------------------------
# See man bash for more options...
# http://wiki.bash-hackers.org/internals/shell_options
#
# Don't wait for job termination notification
set -o notify
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

