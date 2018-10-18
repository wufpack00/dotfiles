# Find a file under the current directory
function ff () { /usr/bin/find . -name "$@" ; }

# Find a file whose name starts with a given string
function ffs () { /usr/bin/find . -name "$@"'*' ; }

# Find a file whose name ends with a given string
function ffe () { /usr/bin/find . -name '*'"$@" ; }

# Find files larger than a certain size (in bytes)
function find_larger() { find . -type f -size +${1}c ; }
