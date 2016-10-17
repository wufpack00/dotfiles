#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables
set -x;

files=".bash* .vim* .gitconfig"    	  # list of files/folders to symlink in homedir

while [ ! $# -eq 0 ]
do
    case "$1" in
        --help | -h)
            echo "Usage is ??"
            exit
            ;;
        --include-all | -a)
            echo "Including all config"
            exit
            ;;
        --include-cygwin | -c)
            echo "Including cygwin config"
            exit
            ;;
        --include-mac | -m)
            echo "Including macos config"
            exit
            ;;
        --include-tmux | -t)
            echo "Including tmux config...Press prefix + I (capital I, as in Install) to fetch the configured tpm plugins."
            files="$files .tmux*"
            exit
            ;;
        --include-work | -w)
            echo "Including work config"
            exit
            ;;
    esac
    shift
done


ts=$(date +"%Y%m%d%H%M%S")
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_$ts             # old dotfiles backup directory

##########

# create dotfiles_old in homedir
mkdir -p $olddir

# change to the dotfiles directory
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
   # if [ -d "$file" ] ; then
   #     echo "$file is a directory"
   #     mv ~/$file $file_$ts
   #     cp -R $dir/$file ~
   # else
        if [ -f "~/$file" ] ; then
            mv ~/$file $olddir/
        fi
        ln -s $dir/$file ~/$file
   # fi
done

source ~/.bashrc
