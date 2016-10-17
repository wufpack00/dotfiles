#!/bin/bash
#-----------------------------
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
#-----------------------------

set -x;

CORE_BASH=".bashrc .bash_aliases .bash_prompt .bash_completion .bash_functions .bash_profile"
CYGWIN_BASH=".bash_cygwin"
MACOS_BASH=".bash_macos"
WORK_BASH=".bash_work"
TMUX_CONFIG=".tmux*"
VIM_CONFIG=".vim*"
GIT_CONFIG=".gitconfig"

# default to only core bash, vim and git dot files
CONFIG_FILES="$CORE_BASH $VIM_CONFIG $GIT_CONFIG"

while getopts ":acmtwh" FLAG
do
    case $FLAG in
        a)
            echo "Including all config"
            CONFIG_FILES="$CONFIG_FILES $CYGWIN_BASH $MACOS_BASH $WORK_BASH $TMUX_CONFIG"
            ;;
        c)
            echo "Including cygwin config"
            CONFIG_FILES="$CONFIG_FILES $CYGWIN_BASH"
            ;;
        h)
            echo "Usage is ?? (at best)"
            exit
            ;;
        m)
            echo "Including macos config"
            CONFIG_FILES="$CONFIG_FILES $MACOS_BASH"
            ;;
        t)
            echo "Including tmux config...Press prefix + I (capital I, as in Install) to fetch the configured tpm plugins."
            CONFIG_FILES="$CONFIG_FILES $TMUX_CONFIG"
            ;;
        w)
            echo "Including work config"
            CONFIG_FILES="$CONFIG_FILES $WORK_BASH"
            ;;
        \?)
            echo "Invalid option: $OPTARG"
            exit
            ;;
    esac
done

#This tells getopts to move on to the next argument.
shift $((OPTIND-1))  

# remove any duplicate entries 
CONFIG_FILES=$( echo "$CONFIG_FILES" | xargs -n1 | sort -u | xargs)

CURRENT_TIMESTAMP=$(date +"%Y%m%d%H%M%S")
SOURCE_DIR=~/dotfiles                    
BACKUP_DIR=~/dotfiles_$CURRENT_TIMESTAMP   


# create a backup directory for existing files
mkdir -p $BACKUP_DIR

# change to the dotfiles directory
cd $SOURCE_DIR

# move any existing dotfiles in homedir to backup directory, then create symlinks 
for file in $CONFIG_FILES; do
   if [ -f ~/$file ] || [ -L ~/$file ] ; then
        mv ~/$file $BACKUP_DIR/
    else
        echo "$file does not exist"
   fi
   ln -s $SOURCE_DIR/$file ~/$file
done

source ~/.bashrc
