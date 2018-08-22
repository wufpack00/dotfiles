# List user defined functions (similar to alias command for listing aliases)
function func ()
{
    local F=`for i in $(declare -F | sed -e 's/declare -f //g'); do echo $i; done| sed -e :a -e 's/^.\{1,25\}$/& /;ta'|tr ' ' '\032'`;
    i=1;
    for f in ${F};
    do
        echo -en "$f";
        echo -en "\n";
    done | tr '\032' " "
}

#
# Make a directory and change to it
#
function mkcd() {
  if [ $# -ne 1 ]; then
         echo "Usage: mkcd <dir>"
         return 1
  else
         mkdir -p "$@" && cd "$_"
  fi
}


#
# prints a ruler the size of the terminal window
#
function ruler() { 
    for s in '....^....|' '1234567890'
    do 
        w=${#s} 
 str=$( for (( i=1; $i<=$(( ($COLUMNS + $w) / $w )) ; i=$i+1 )); do echo -n $s; done ) 
 str=$(echo $str | cut -c -$COLUMNS)
 echo $str
    done
}

#
# Prints out a long line. Useful for setting a visual flag in your terminal.
#
function flag(){
    echo -e  "\e[1;36m[==============="$@"===\
             ($(date +"%A %e %B %Y %H:%M"))\
             ===============]\e[m"
}

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

#
# Backup file(s)
#
function dbackup(){
    if [ $# -lt 1 ]
    then
        echo Please supply a file to backup
        return 1
    fi
    date=`date +%Y%m%d-%H%M`
    for i in "$@"
    do
        echo Backed up $i to $i.$date
        cp $i $i.$date
    done
}


#-----------
# Searching:
#-----------
# Find a file under the current directory
function ff () { /usr/bin/find . -name "$@" ; }

# Find a file whose name starts with a given string
function ffs () { /usr/bin/find . -name "$@"'*' ; }

# Find a file whose name ends with a given string
function ffe () { /usr/bin/find . -name '*'"$@" ; }

# Find files larger than a certain size (in bytes)
function find_larger() { find . -type f -size +${1}c ; }

#-----------
# Multiplexer 
#----------
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
