# .bash_profile is executed for login shells

if [ -f $HOME/.bashrc ]; then
  source $HOME/.bashrc
fi

# load all files common to login for both shells
if [ -d $HOME/.dotfiles/.login.d ]; then
  for file in $HOME/.dotfiles/.login.d/*.sh; do
    source $file
  done
fi
