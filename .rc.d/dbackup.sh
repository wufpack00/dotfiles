#
# Backup file(s)
#
function dbackup(){
    if [ $# -lt 1 ]
    then
        echo Please supply a file to backup
        return 1
    fi
    date=`date +%Y%m%d-%H%M%S`
    for i in "$@"
    do
        echo Backed up $i to $i.$date
        cp $i $i.$date
    done
}
