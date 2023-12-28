function func() {
   print -l ${(ok)functions}
}

function list_all() {
    emulate -L zsh
    ll
}
# executed whenever the current working directory is changed
chpwd_functions=(${chpwd_functions[@]} "list_all")