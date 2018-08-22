if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
    # activate virtualenvwrapper
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/git-checkouts
    source /usr/local/bin/virtualenvwrapper.sh

    # pip should only run if there is a virtualenv currently activated
    export PIP_REQUIRE_VIRTUALENV=true

    gpip2(){
        PIP_REQUIRE_VIRTUALENV="" pip2 "$@"
    }
    gpip3(){
        PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
    }
    eval "$(direnv hook bash)"
fi
