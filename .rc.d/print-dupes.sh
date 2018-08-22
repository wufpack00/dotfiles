#
# print duplicate lines in file
#
function dupes() { 
    sort "$@" | uniq -d
}
