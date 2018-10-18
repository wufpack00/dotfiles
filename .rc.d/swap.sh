#
# Swap two files
#
function swap(){
    if [ $# -ne 2 ]
    then
        echo Usage: swap file1 file2
        return 1
    fi
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}
