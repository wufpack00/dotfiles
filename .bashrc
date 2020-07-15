#!/bin/bash

# .bashrc is executed for interactive non-login shells
if [[ $- != *i* ]] ; then
  # shell is non-interactive. be done now!
  return
fi

# load all files that apply to both shells
if [ -d $HOME/.dotfiles/.rc.d ]; then
  for file in $HOME/.dotfiles/.rc.d/*.sh; do
    source $file
  done
fi

# load all bash-specific files
if [ -d $HOME/.dotfiles/.bashrc.d ]; then
  for file in $HOME/.dotfiles/.bashrc.d/*.sh; do
    source $file
  done
fi
