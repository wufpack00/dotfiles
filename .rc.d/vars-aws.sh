# set variables for default profile
if command_exists ruby ; then
    $($HOME/.dotfiles/bin/aws-switch.rb)
fi
