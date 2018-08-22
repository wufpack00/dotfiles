function executing_env() {
    local uname="$(uname -s)"
    local machine="UNKNOWN:$uname"
    case "$uname" in
        Linux*)     machine=Linux;;
        Darwin*)    machine=Mac;;
        CYGWIN*)    machine=Cygwin;;
        MINGW*)     machine=MinGw;;
        *)          machine="UNKNOWN:$uname"
    esac
    echo $machine
}

function is_windows() {
    if [ "$(executing_env)" == "MinGw" ] ; then
        return 0
    fi
    return 1
}

function is_cygwin() {
    if [ "$(executing_env)" == "Cygwin" ] ; then
        return 0
    fi
    return 1
}

function is_mac() {
    if [ "$(executing_env)" == "Mac" ] ; then
        return 0
    fi
    return 1
}

function is_nix() {
    if [ "$(executing_env)" == "Linux" ] ; then
        return 0
    fi
    return 1
}

