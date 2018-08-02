#!/bin/bash
#-----------------------------
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
#-----------------------------

#set -x;

declare -r SCRIPT_PATH=$( cd "$(dirname ${BASH_SOURCE[0]})" > /dev/null; pwd -P )
source $SCRIPT_PATH/../.bash_functions

readonly CURRENT_TIMESTAMP=$(date +"%Y%m%d%H%M%S")

readonly CORE_BASH=".bashrc .bash_aliases .bash_prompt .bash_completion .bash_functions .bash_profile"
readonly CYGWIN_BASH=".bash_cygwin"
readonly MACOS_BASH=".bash_macosx"
readonly WORK_BASH=".bash_work"
readonly TMUX_CONFIG=".tmux*"
readonly VIM_CONFIG=".vim*"
readonly GIT_CONFIG=".gitconfig"

if is_windows ; then
    # https://github.com/git-for-windows/git/pull/156
    export MSYS=winsymlinks:nativestrict
fi

# default to only core bash, vim and git dot files
CONFIG_FILES="$CORE_BASH $VIM_CONFIG $GIT_CONFIG"

# options for determing which files to include
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
            echo "Usage: bootstrap.sh [OPTION] <source-dir:~/dotfiles> <target-dir:~>"
            echo "  -a      Include all files"
            echo "  -c      Include default + cygwin files"
            echo "  -m      Include default + macos files"
            echo "  -t      Include default + tmux files"
            echo "  -w      Include default + work files"
            echo "  -h      Display this message"
            exit
            ;;
        m)
            echo "Including macosx config"
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

# must be defined after options are read
readonly SOURCE_DIR=${1:-~/dotfiles}
readonly TARGET_DIR=${2:-~}
readonly BACKUP_DIR=$TARGET_DIR/dotfiles_$CURRENT_TIMESTAMP   

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

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> ~/.git-completion.bash
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh >> ~/.git-prompt.sh

source $TARGET_DIR/.bashrc
