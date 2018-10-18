# load all files that apply to both shells
if [ -d $HOME/.dotfiles/.rc.d ]; then
  for file in $HOME/.dotfiles/.rc.d/*.sh; do
    source $file
  done
fi

# load all zsch-specific files
if [ -d $HOME/.dotfiles/.zshrc.d ]; then
  for file in $HOME/.dotfiles/.zshrc.d/*.sh; do
    source $file
  done
fi
