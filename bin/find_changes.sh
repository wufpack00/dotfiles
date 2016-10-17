#!/bin/bash

if [ "$1" == "" ] ; then
    SRC_DIR=$PWD
else
    SRC_DIR=$1
fi

PARENT_DIR=$(basename $SRC_DIR)

shopt -s dotglob

recurse() {
  # $1 = directory passed as argument to function
  for file in $1/* ; do

    filename=$(basename "$file")
    dirname=$(basename $(dirname "$file"))

    if [ -d "$file" ] ; then
        if [ "$filename" != ".git" ]; then
            recurse $file 
        fi
    else
        if [ "$dirname" != "$PARENT_DIR" ] ; then
            if [ -f "${HOME}/$dirname/$filename" ]; then
                diff -q $file ${HOME}/$dirname/$filename
            fi
        elif [ -f "${HOME}/$filename" ]; then
            diff -q $file ${HOME}/$filename
        fi
    fi
  done
}

recurse $SRC_DIR
