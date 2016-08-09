# Functions
#
# Some example functions:
#
# a) function settitle
# settitle () 
# { 
#   echo -ne "\e]2;$@\a\e]1;$@\a"; 
# }
# 
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
   dirs -v
   return 0
  fi
 
  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi
 
  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)
  
  #
  # List directory contents upon successful 'cd'
  ls -FlAhp --color=always

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}

alias cd=cd_func


# List user defined functions (similar to alias command for listing aliases)
func ()
{
    local F=`for i in $(declare -F | sed -e 's/declare -f //g'); do echo $i; done| sed -e :a -e 's/^.\{1,25\}$/& /;ta'|tr ' ' '\032'`;
    i=1;
    for f in ${F};
    do
        echo -en "$f";
        echo -en "\n";
    done | tr '\032' " "
}

# Extract zipped files based on file type
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1        ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xvf $1        ;;
            *.tbz2)      tar xvjf $1      ;;
            *.tgz)       tar xvzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

#
# Make a directory and change to it
#
mkcd() {
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
ruler() { 
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
flag(){
    echo -e  "\e[1;36m[==============="$@"===\
             ($(date +"%A %e %B %Y %H:%M"))\
             ===============]\e[m"
}

#
# Swap two files
#
swap(){
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
dbackup(){
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

#
# print duplicate lines in file
#
dupes() { 
    sort "$@" | uniq -d
}


#-----------
# Searching:
#-----------
# Find a file under the current directory
ff () { /usr/bin/find . -name "$@" ; }

# Find a file whose name starts with a given string
ffs () { /usr/bin/find . -name "$@"'*' ; }

# Find a file whose name ends with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }

# Find files larger than a certain size (in bytes)
find_larger() { find . -type f -size +${1}c ; }

#-----------
# History:
#----------
# If no parameters passed, call history otherwise grep for parameter in history
function h() {
    if [ -z "$1" ]
    then
        history
    else
        history | grep "$@"
    fi
}

function screen_func {
    if [ -z "$1" ]
    then
        screen
    else
        screen -c ~/.screenrc-$1
    fi
}


alias screen=screen_func
