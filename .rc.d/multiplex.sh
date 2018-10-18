function screen_func {
    if [ -z "$1" ]
    then
        screen -c $HOME/.screenrc.local
    else
        screen -c $HOME/.screenrc.$1
    fi
}


alias screen=screen_func

function mux_func {
    if [ -z "$1" ]
    then
        mux start default
    else
        mux start $1
    fi
}


alias mstart=mux_func
