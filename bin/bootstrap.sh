#!/bin/bash
#-----------------------------
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
#-----------------------------

#set -x;

declare -r SCRIPT_PATH=$( cd "$(dirname ${BASH_SOURCE[0]})" > /dev/null; pwd -P )
source $SCRIPT_PATH/../.rc.d/get-env.sh

readonly CURRENT_TIMESTAMP=$(date +"%Y%m%d%H%M%S")

readonly CORE_BASH=".bashrc .bash_profile"
readonly TMUX_CONFIG=".tmux*"
readonly VIM_CONFIG=".vim*"
readonly GIT_CONFIG=".gitconfig"
readonly LOCAL_CONFIG=".gitconfig.local .bash.local"

if is_windows ; then
    # https://github.com/git-for-windows/git/pull/156
    export MSYS=winsymlinks:nativestrict
fi

# default to only core bash, vim and git dot files
CONFIG_FILES="$CORE_BASH $VIM_CONFIG $GIT_CONFIG"

# options for determing which files to include
while getopts ":ath" FLAG
do
    case $FLAG in
        a)
            echo "Including all config"
            CONFIG_FILES="$CONFIG_FILES $TMUX_CONFIG"
            ;;
        h)
            echo "Usage: bootstrap.sh [OPTION] <source-dir:~/dotfiles> <target-dir:~>"
            echo "  -a      Include all files"
            echo "  -c      Include default + cygwin files"
            echo "  -m      Include default + macos files"
            echo "  -t      Include default + tmux files"
            echo "  -w      Include default + work files"
            echo "  -h      Display this message"
            exit
            ;;
        t)
            echo "Including tmux config...Press prefix + I (capital I, as in Install) to fetch the configured tpm plugins."
            CONFIG_FILES="$CONFIG_FILES $TMUX_CONFIG"
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

# must be defined after options are read
readonly SOURCE_DIR=${1:-$HOME/.dotfiles}
readonly TARGET_DIR=${2:-$HOME}
readonly BACKUP_DIR=$TARGET_DIR/.dotfiles_$CURRENT_TIMESTAMP   

# create a backup directory for existing files
mkdir -p $BACKUP_DIR

# change to the dotfiles directory
cd $SOURCE_DIR

# move any existing dotfiles in homedir to backup directory, then create symlinks 
for file in $CONFIG_FILES; do
   if [ -f $TARGET_DIR/$file ] || [ -L $TARGET_DIR/$file ] ; then
        mv $TARGET_DIR/$file $BACKUP_DIR/
    else
        echo "$file does not exist...skipping backup"
   fi

    if [ $file == "$WORK_BASH" ] ; then
        # don't create symlink for .bash_work since it is template
        cp $SOURCE_DIR/$file $TARGET_DIR/$file
    else
        echo "creating symlink for $SOURCE_DIR/$file -> $TARGET_DIR/$file"
        ln -s $SOURCE_DIR/$file $TARGET_DIR/$file
    fi
done

source $TARGET_DIR/.bashrc
