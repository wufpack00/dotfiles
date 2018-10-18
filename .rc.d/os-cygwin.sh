if ! is_cygwin ; then
    return
fi

# Required for colored manpages to work
export GROFF_NO_SGR=1

alias cs='cygstart'
# open windows explorer in current directory
alias open='/cygdrive/c/Windows/explorer.exe /e,`cygpath -wa "$1"`'
